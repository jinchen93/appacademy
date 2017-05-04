const TweetUtil = {
  generateTweetListItem: function(res) {
    const $li = $('<li></li>');
    $li.append(res.content + ' -- ');
    $li.append($(`<a href="/users/${res.user_id}">${res.user.username}</a> `));
    $li.append(`-- ${res.created_at}`);
    $li.append(this.renderMentions(res.mentions));
    return $li;
  },

  renderMentions: function(mentions) {
    if (mentions.length > 0) {
      const $ul = $('<ul></ul>');
      mentions.forEach(mention => {
        const $li = $('<li></li>');
        $li.append(
          `<a href="/users/${mention.user_id}">${mention.user.username}</a>`
        );
        $ul.append($li);
      });
      return $ul;
    } else {
      return '';
    }
  },

  findFeed: function() {
    const feed = this.$el.data('tweets-ul');
    return $(feed);
  }
};

module.exports = TweetUtil;
