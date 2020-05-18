<template>
    <div class="row">
        <div 
        class="col-6 col-md-4 p-3"
        style="border: 1px solid #ccc"
        v-for="image in images"
        :key="image"
        v-on:click="showImage(image)"
        >
            <b-img-lazy v-bind:src="url + image"/>
        </div>
        <b-modal id="current-image" title="" hide-footer=true hide-header=true1 size="xl">
            <b-img v-bind:src="url + currentImage"></b-img>
        </b-modal>
    </div>
</template>

<script>
import axios from 'axios'
import config from '../../config/local.json'
export default {
  name: 'gallery',
  created: function() {
    this.url = config.image_url;
    axios.get(this.url + 'images.json')
    .then(response => {this.images = response.data; console.log(response);})
  },
  data () {
    return {
        url: '',
        images: [],
        currentImage: '',
    }
  },
  methods: {
      showImage: function(image) {
          this.currentImage = image;
          this.$bvModal.show('current-image');
      }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
img {
    max-width: 100%;
    max-height: 100%;
}
#current-image img {
    max-height: calc(100vh - 80px);
}
</style>
