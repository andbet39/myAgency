<template>
  <div class="row">
      <table class="table">
        <thead>
          <th>Title</th>
          <th>Price</th>
          <th>Mq </th>
          <th>Price/Mq </th>
          <th>Tel.</th>
          <th>Link</th>
          <th>Source</th>
          <th colspan="2">
        </thead>
        <tbody>
          <listing-row v-for="listing in listings" v-bind:listing="listing" ></listing-row>
        </tbody>
      </table>

  </div>
</template>

<script>
import axios from 'axios'

export default {
  props:['searchid'],
  data:function(){
    return {
      listings:[],
    }
  },
  mounted() {
          axios.get('/listings.json' ).then((res)=>{
            console.log(res);
            this.listings = res.data;
          });
          console.log('Component mounted.')
      }
}
</script>

<style lang="css">
</style>
