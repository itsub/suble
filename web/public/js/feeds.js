var createFeed = new Vue({
  el: '#new-feed',
  data: {
    name: '',
    link: '',
    description: ''
  },
  methods: {
    createFeed: function() {
      axios.post('/feeds/new',
        {
          name: this.name,
          link: this.link,
          description: this.description
        }
      ).then(function(response) {
        console.log(response);
      });
    }
  }
});
