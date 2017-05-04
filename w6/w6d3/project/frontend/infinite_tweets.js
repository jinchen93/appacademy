const TweetUtil = require('./tweet_util');
const APIUtil = require('./api_util');

class InfiniteTweets {
  constructor($el) {
    this.$el = $el;
    this.$feed = TweetUtil.findFeed.apply(this);
    this.maxCreatedAt = null;
    this.bindEvents();
  }

  bindEvents() {
    this.$el.on('click', e => this.handleClick(e));
  }


  handleClick(e) {
    e.preventDefault();
    if (this.maxCreatedAt) {
      APIUtil.fetchTweets(this.maxCreatedAt)
      .then(tweets => this.insertTweets(tweets));
    } else {
      APIUtil.fetchTweets()
      .then(tweets => this.insertTweets(tweets));
    }
  }

  insertTweets(tweets) {
    tweets.forEach(tweet => {
      const $li = TweetUtil.generateTweetListItem(tweet);
      this.$feed.append($li);
    });
    if (tweets.length > 0) {
      const lastTweet = tweets[tweets.length - 1];
      this.maxCreatedAt = lastTweet.created_at;
    }
  }

}

module.exports = InfiniteTweets;
