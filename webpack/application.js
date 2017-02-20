
import Vue from 'vue';
import {ServerTable, ClientTable, Event} from 'vue-tables-2';

Vue.component('prova', require('./prova.vue'));
Vue.component('listing-row', require('./listing-row.vue'));
Vue.component('like-button', require('./like-button.vue'));

Vue.use(ClientTable);

    var app =   new Vue({
        el: '#app',
        data: {
            message: 'Hello Vue.js!',
        }
    });
