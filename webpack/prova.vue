<template>
  <div class="row">
      <v-client-table :data="listings" :columns="columns" :options="options"></v-client-table>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data:function(){
    return {
      columns:['title','tel','tel2','mt','price'],
      listings:[],
      options:{
        
      }
    }
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
