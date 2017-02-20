
import Vue from 'vue';
import {ServerTable, ClientTable, Event} from 'vue-tables-2';
import Vue2Filters from 'vue2-filters'

Vue.component('prova', require('./prova.vue'));
Vue.component('listing-row', require('./listing-row.vue'));
Vue.component('like-button', require('./like-button.vue'));
Vue.component('fav-button', require('./fav-button.vue'));

Vue.use(ClientTable);
Vue.use(Vue2Filters);



    var app =   new Vue({
        el: '#app',
        data: {
            message: 'Hello Vue.js!',
        }
    });
