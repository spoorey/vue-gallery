<template>
    <div class="row">
        <div class="col-12">
            <div>
                <b-embed type="video" controls autoplay>
                    <source v-bind:src="url + 'timelapse.webm'" type="video/webm">
                </b-embed>
            </div>
        </div>

        <div 
        class="col-6 col-md-4 image-panel p-2"
        v-for="(file, index) in images"
        :key="file"
        v-on:click="showImage(index)"
        >
            <b-img-lazy v-bind:src="url + file"/>
        </div>
        <b-modal id="current-image" title="" hide-footer hide-header size="lg">
            <a
            class="carousel-control-prev" role="button" 
            v-if="currentImage > 0"
            v-on:click="showImage(currentImage-1)">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            </a>
            <b-img v-bind:src="url + images[currentImage]"></b-img>
            <a
                class="carousel-control-next" role="button"
                v-if="currentImage < images.length - 1"
                v-on:click="showImage(currentImage+1)">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>
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
        currentImage: null,
    }
  },
  methods: {
      showImage: function(imageIndex) {
        this.currentImage = imageIndex;
        this.$bvModal.show('current-image');

        var preload = new Image();
        if (imageIndex > 0) {
            preload.src = this.images[imageIndex-1];
        }

        if (imageIndex < this.images.length - 1) {
            preload.src = this.images[imageIndex + 1];
        }
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
.image-panel {
    cursor: pointer;
}

.image-panel img {
    border-radius: 5px;
}
.image-panel img:hover {
    box-shadow: 0px 0px 5px 5px #bbb;
}
</style>
