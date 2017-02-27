
<template >
  <tr>
    <td><i style="color:red" v-if="listing.isnew" class="fa fa-exclamation red" aria-hidden="true"></i></td>
    <td><a :href="showlink">{{listing.title}}</a></td>
    <td>{{listing.price | currency('€',0) }}</td>
    <td>{{listing.mt}}</td>
    <td>{{priceMq | currency('€',0) }}</td>
    <td>{{listing.tel}}</td>
    <td><a :href="listing.link">Link</a></td>
    <td>{{listing.origin}}</td>
    <td><fav-button :is_fav="listing.favourite"  @togglefav="togglefav"></fav-button></td>
    <td><a v-bind:href="interactionUrl"><button class="btn btn-sm btn-success" ><i class="fa fa-phone" aria-hidden="true"></i></button></a></td>
  </tr>
</template>

<script>
import axios from 'axios'

export default {
    props:['listing'],
    methods:{
        togglefav:function(fav){
          this.listing.favourite = fav;
          axios.get('/api/togglefav?listing_id='+this.listing.id).then(function(res){
            console.log(res.data);
          });
        }
    },
    computed:{
      priceMq: function() {
        return (this.listing.price / this.listing.mt)
      },
      interactionUrl: function(){
        return ('/my_interaction/new?listing_id='+this.listing.id+'&inttype=Tel');
      },
      showlink: function(){
        return ('/listings/'+this.listing.id);
      }

    }
}
</script>

<style lang="css">
red:{
  color:red
}
</style>
