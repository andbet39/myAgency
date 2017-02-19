<template>
  <div>
      <h2>Listing</h2>
      <ul>
        <li v-for="listing in listings">
           {{listing.title}}
        </li>
      </ul>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data:function(){
    return {listings:[]}
  },
  mounted() {
          axios.get('/listings.json').then((res)=>{
            console.log(res);
            this.listings = res.data;
          });
          console.log('Component mounted.')
      }
}
</script>

<style lang="css">
</style>
