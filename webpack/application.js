
import Vue from 'vue';
import {ServerTable, ClientTable} from 'vue-tables-2';
import Vue2Filters from 'vue2-filters'
import {VueForm, Event} from 'vue-form-2'


Vue.component('listing-row', require('./component/listing-row.vue'));
Vue.component('like-button', require('./component/like-button.vue'));
Vue.component('fav-button', require('./component/fav-button.vue'));
Vue.component('interaction-form',require('./component/interaction-form.vue'));
Vue.component('listings',require('./listings.vue'));

Vue.use(ClientTable);
Vue.use(Vue2Filters);
Vue.use(VueForm);

/*
var app =   new Vue({
    el: '#app',
    data: {
        message: 'Hello Vue.js!',
    }
});
*/
