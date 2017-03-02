<template>
        <div class="x_panel">
          <div class="x_content">
            <vf-form action="/my_interaction/create" method="POST" :options="formOption">
              <vf-status-bar ref="statusbar"></vf-status-bar>
              <vf-text label="Name:" required name="name" ref="name"></vf-text>
              <vf-number label="Vote:" name="vote" ref="vote"></vf-number>
              <vf-number label="Interest:"  name="interest" ref="interest"></vf-number>
              <vf-textarea label="Note:" name="note" ref="note"></vf-textarea>
              <vf-submit></vf-submit>
            </vf-form>
          </div>
      </div>
</template>

<script>
import axios from 'axios'

export default {
  props:['inttype','listingid'],
  data:function(){
    return {
      formOption:{
        additionalPayload : {listing_id: this.listingid, inttype:this.inttype}
      }
    }
  }
}
</script>

<style lang="css">
</style>
