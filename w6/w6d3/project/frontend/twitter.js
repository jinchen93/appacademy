const FollowToggle = require('./follow_toggle');

$( () => {
  const $allFollowBtns = $('.follow-toggle');
  $allFollowBtns.each( (idx, btn) => {
    new FollowToggle($(btn));
  });
});
