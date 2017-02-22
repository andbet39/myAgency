<template>
    <button class="btn btn-primary" v-on:click="togglefav" ><i v-bind:class="[is_fav ?  'fa-heart' : 'fa-heart-o', 'fa']" aria-hidden="true"></i></button>
</template>

<script>
export default {
    props:['is_fav'],
    methods:{
      togglefav:function(){
        console.log(this.is_fav);
        this.$emit('togglefav',!this.is_fav);
      }
    }
}
</script>

<style lang="css">
</style>
