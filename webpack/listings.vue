<template>
  <div class="row">
      <div class="col-md-1-12">
        <div class="row">
          <div class="col-md-2">
            Filters :
          </div>
          <div class="col-md-2">
            <button class="btn btn-primary" v-on:click="togglefav" ><i v-bind:class="[onlyfav ?  'fa-heart' : 'fa-heart-o', 'fa']" aria-hidden="true"></i></button>
          </div>
        </div>
        <br>
        <table class="table table-bordered">
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
            <listing-row v-for="listing in this.filteredListing" v-bind:listing="listing" ></listing-row>
          </tbody>
        </table>
      </div>

  </div>
</template>

<script>
import axios from 'axios'

export default {
  props:['searchid'],
  data:function(){
    return {
      listings:[],
      onlyfav:false,
    }
  },
  mounted() {
        if( this.searchid != null ){
          axios.get('/api/listing_for_search?search_id='+this.searchid ).then((res)=>{
            console.log(res);
            this.listings = res.data;
          });
        }else{
          axios.get('/listings.json' ).then((res)=>{
            console.log(res);
            this.listings = res.data;
          });
        }

          console.log('Component mounted.')
      },
  computed: {
    filteredListing: function(){
      var filtered =[];
      if( this.onlyfav == true){
          this.listings.forEach((listing)=>{
            if (listing.favourite == true) filtered.push(listing);
          });
      }else{
          filtered =  this.listings;
      }

      return filtered;
    }
  },
  methods:{
    togglefav:function(){
      this.onlyfav = !this.onlyfav;
    }
  }
}
</script>

<style lang="css">
</style>
