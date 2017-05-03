const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const TweetCompose = require('./tweet_compose');

$( () => {
  const $allFollowBtns = $('.follow-toggle');
  $allFollowBtns.each( (idx, btn) => {
    new FollowToggle($(btn));
  });

  const $userSearch = $('nav.users-search');
  new UsersSearch($userSearch);

  const $tweetCompose = $('.tweet-compose');
  new TweetCompose($tweetCompose);
});
