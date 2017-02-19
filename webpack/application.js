
import Vue from 'vue';

Vue.component('prova', require('./prova.vue'));

    var app =   new Vue({
        el: '#app',
        data: {
            message: 'Hello Vue.js!',
        }
    });
