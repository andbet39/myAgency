<template>
  <div class="row">

    <h2>Nuova interazione </h2>
    <vf-form action="/my_interaction/create" method="POST" :options="formOption">
      <vf-status-bar ref="statusbar"></vf-status-bar>
      <vf-text label="Name:" required name="name" ref="name"></vf-text>
      <vf-number label="Vote:" name="vote" ref="vote"></vf-number>
      <vf-number label="Interest:"  name="interest" ref="interest"></vf-number>
      <vf-textarea label="Note:" name="note" ref="note"></vf-textarea>
      <vf-submit></vf-submit>
    </vf-form>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  props:['listingid','type'],
  data:function(){
    return {
      formOption:{
        additionalPayload : {listing_id: this.listingid, type:this.type}
      }
    };
  },
  computed: {
    typeSelect:[
    {id:1, text:'Option A'},
    {id:2, text:'Option B'},
    {id:3, text:'Option C'}
  ],
  curValue:{}
},
  filterBy:null
}
</script>

<style lang="css">
</style>
