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
          <div class="col-md-2">
            <button class="btn btn-primary" v-on:click="togglenew" ><i v-bind:class="[onlynew ?  'fa-exclamation-triangle' : 'fa-exclamation', 'fa']" aria-hidden="true"></i></button>
          </div>
        </div>
        <br>
        <table class="table table-bordered">
          <thead>
            <th>New</th>
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
      onlynew:false
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
      var filtered = this.listings;

      if( this.onlyfav == true){
        filtered = filtered.filter(function(listing){
            console.log("filter");
            return listing.favourite
        });
      }
      if( this.onlynew == true){
          filtered = filtered.filter(function(listing){
              console.log("filter");
              return listing.isnew
          });
      }



      return filtered;
    }
  },
  methods:{
    togglefav:function(){
      this.onlyfav = !this.onlyfav;
    },
    togglenew:function(){
      this.onlynew = !this.onlynew;
      console.log(this.onlynew);
    }
  }
}

</script>

<style lang="css">
</style>
