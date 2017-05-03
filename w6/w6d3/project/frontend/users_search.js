const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

class UsersSearch {
  constructor($el) {
    this.$input = $el.find('.search-input');
    this.$ul = $el.find('.users');
    this.bindEvent();
  }

  bindEvent() {
    this.$input.on('keyup', e => this.handleInput(e));
  }

  handleInput(e) {
    this.resetList();
    let val = e.currentTarget.value;
    APIUtil.searchUsers(val)
      .then(users => this.handleUsers(users));
  }

  handleUsers(users) {
    users.forEach(user => {
      this.$ul.append(this.updateList(user));
    });
  }

  makeNewFollowToggle($ele, user) {
    new FollowToggle($ele, {
      userId: user.id,
      followState: user.followed ? 'followed' : 'unfollowed'
    });
  }

  resetList() {
    this.$ul.html('');
  }

  updateList(user) {
    let $li = $('<li></li>');
    let $link = $(`<a href="/users/${user.id}">${user.username}</a>`);
    let $followBtn = $(`<button></button>`);

    this.makeNewFollowToggle($followBtn, user);

    $link.append($followBtn);
    $li.append($link);
    return $li;
  }
}

module.exports = UsersSearch;
