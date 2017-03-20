const path = require('path');
const fs = require('fs-extra');
const pkg = require('./package.json');

const SH_TEMPLATE = binPath =>
`#!/bin/sh
basedir=$(dirname "$(echo "$0" | sed -e 's,\\\\,/,g')")

case \`uname\` in
    *CYGWIN*) basedir=\`cygpath -w "$basedir"\`;;
esac

if [ -x "$basedir/node" ]; then
  "$basedir/node"  "$basedir/../${binPath}" "$@"
  ret=$?
else
  node  "$basedir/../${binPath}" "$@"
  ret=$?
fi
exit $ret
`;

const CMD_TEMPLATE = binPath =>
`@IF EXIST "%~dp0\\node.exe" (
  "%~dp0\\node.exe"  "%~dp0\\..\\${binPath}" %*
) ELSE (
  @SETLOCAL
  @SET PATHEXT=%PATHEXT:;.JS;=;%
  node  "%~dp0\\..\\${binPath}" %*
)
`;

function createLink(linkName, templateFn, binPathRelative) {
  const linkPath = path.resolve(process.cwd(), 'node_modules', '.bin', linkName);
  fs.writeFile(linkPath, templateFn(binPathRelative), {
    mode: 755,
  });
}

function createLinks(err) {
  if (err) throw new Error(err);

  // Get the names of all regular and dev dependencies
  const modules = [
    ...Object.keys(pkg.dependencies),
    ...Object.keys(pkg.devDependencies),
  ];

  const binLinks = modules.reduce((previousValue, currentValue) => {
    const modulePkg = require(`./node_modules/${currentValue}/package.json`);
    if (modulePkg.bin) {
      // `bin` property can be a string or an object
      // so they have to be parsed differently
      if (typeof modulePkg.bin === 'string') {
        return [
          ...previousValue,
          {
            moduleName: currentValue,
            name: currentValue,
            link: modulePkg.bin,
          },
        ];
      } else if (typeof modulePkg.bin === 'object') {
        return [
          ...previousValue,
          ...Object.keys(modulePkg.bin).map(name => ({
            moduleName: currentValue,
            name,
            link: modulePkg.bin[name],
          })),
        ];
      }
    }
    return previousValue;
  }, []);

  binLinks.forEach((binLink) => {
    const nodeModulesPathAbsolute = path.resolve(process.cwd(), 'node_modules');
    const binPathAbsolute = path.resolve(nodeModulesPathAbsolute, binLink.moduleName, binLink.link);
    const binPathRelative = path.relative(nodeModulesPathAbsolute, binPathAbsolute);
    if (fs.existsSync(binPathAbsolute)) {
      // Create link for POSIX
      const binPathRelativeSh = binPathRelative.replace(new RegExp(`\\${path.sep}`, 'g'), '/');
      createLink(binLink.name, SH_TEMPLATE, binPathRelativeSh);

      // Create link for Windows
      const binPathRelativeCmd = binPathRelative.replace(new RegExp(`\\${path.sep}`, 'g'), '\\');
      createLink(`${binLink.name}.cmd`, CMD_TEMPLATE, binPathRelativeCmd);
    }
  });
}

const binPath = path.resolve(process.cwd(), 'node_modules', '.bin');
fs.mkdirp(binPath, createLinks);
