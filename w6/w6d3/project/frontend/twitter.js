const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const TweetCompose = require('./tweet_compose');
const InfiniteTweets = require('./infinite_tweets');

$( () => {
  const $allFollowBtns = $('.follow-toggle');
  $allFollowBtns.each( (idx, btn) => {
    new FollowToggle($(btn));
  });

  const $userSearch = $('nav.users-search');
  new UsersSearch($userSearch);

  const $tweetCompose = $('.tweet-compose');
  new TweetCompose($tweetCompose);

  const $infiniteTweets = $('a.fetch-more');
  new InfiniteTweets($infiniteTweets);
});
