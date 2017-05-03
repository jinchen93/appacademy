const APIUtil = require('./api_util');

class FollowToggle {
  constructor($el) {
    this.$el = $el;
    this.userId = $el.data('user-id');
    this.followState = $el.data('initial-follow-state');
    this.render();
    this.bindClick();
  }

  render() {
    if (this.processing()) {
      this.$el.text(this.followState + '...');
      this.$el.prop('disabled', true);
    } else {
      let text = this.isFollow() ? 'Unfollow!' : 'Follow!';
      this.$el.prop('disabled', false);
      this.$el.text(text);
    }
  }

  processing() {
    return (
      this.followState === 'following'||
      this.followState === 'unfollowing'
    );
  }

  isFollow() {
    return this.followState === 'followed';
  }

  bindClick() {
    this.$el.on('click', e => this.handleClick(e));
  }

  handleClick(e) {
    e.preventDefault();

    if (this.isFollow()) {
      this.freezeButton('unfollowing');
      this.unfollow();
    } else {
      this.freezeButton('following');
      this.follow();
    }
  }

  freezeButton(state) {
    this.followState = state;
    this.render();
  }

  follow() {
    APIUtil.followUser(this.userId)
      .then( () => this.update('followed'));
  }

  unfollow() {
    APIUtil.unfollowUser(this.userId)
      .then( () => this.update('unfollowed'));
  }

  update(state) {
    console.log(state);
    this.followState = state;
    this.render();
  }
}

module.exports = FollowToggle;
