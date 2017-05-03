const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const TweetCompose = require('./tweet_compose');

$( () => {
  const $allFollowBtns = $('.follow-toggle');
  $allFollowBtns.each( (idx, btn) => {
    new FollowToggle($(btn));
  });

  let $userSearch = $('nav.users-search');
  new UsersSearch($userSearch);
});
