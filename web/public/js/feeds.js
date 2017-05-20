var createFeed = new Vue({
  el: '#new-feed',
  data: {
    name: '',
    link: '',
    description: ''
  },
  methods: {
    createFeed: function() {
      var c = this;
      axios.post('/feeds/new',
        {
          name: this.name,
          link: this.link,
          description: this.description
        }
      ).then(function(response) {
        console.log(response);
        var feedsList = document.getElementById('feeds-list');
        feedsList.innerHTML = '<tr><td>' +
                  [c.name, c.link, c.description, '<i class="icon ion-happy-outline"></i>'].join('</td><td>') +
          '</td></tr>' + feedsList.innerHTML;
      });
    }
  }
});

function deleteFeed(fid) {
  //var sure = confirm('Are you sure?');
  //if (!sure) return;

  axios.delete('/feeds/delete/' + fid.toString()).
    then(function(response) {
      document.getElementById('feed-' + fid).style.display = 'none';
    }
  );;
}
