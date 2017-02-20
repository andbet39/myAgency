
<template >
  <tr>
    <td>{{listing.title}}</td>
    <td>{{listing.price | currency('€',0) }}</td>
    <td>{{listing.mt}}</td>
    <td>{{priceMq | currency('€',0) }}</td>
    <td>{{listing.tel}}</td>
    <td><a :href="listing.link">Link</a></td>
    <td>{{listing.origin}}</td>
    <td><fav-button :is_fav="listing.favourite"  @togglefav="togglefav"></fav-button></td>
    <td><button class="btn btn-success" ><i class="fa fa-phone" aria-hidden="true"></i></button></td>
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
      }

    }
}
</script>

<style lang="css">
</style>
