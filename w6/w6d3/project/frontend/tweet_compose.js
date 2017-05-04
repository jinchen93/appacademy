const TweetUtil = require('./tweet_util');
const APIUtil = require('./api_util');

class TweetCompose {
  constructor($el) {
    this.$el = $el;
    this.$feed = TweetUtil.findFeed.apply(this);
    this.$mentionedUsers = $('.mentioned-users');
    this.bindEvents();
  }

  addMentionedUser(e) {
    e.preventDefault();
    const selectHTML = this.$el.find('script').html();
    this.$mentionedUsers.append(selectHTML);
    this.bindMentionEvent();
    return false;
  }

  bindEvents() {
    this.$el.on('submit', e => this.submit(e));
    this.$el.find('textarea').on('input', e => this.handleCharsLeft(e));
    $('a.add-mentioned-user').on('click', e => {
      this.addMentionedUser(e);
    });
  }

  bindMentionEvent() {
    $('a.remove-mentioned-user').on('click', e => {
      this.removeMentionedUser(e);
    });
  }

  clearInput() {
    const $textarea = this.$el.find('textarea');
    const $mentions = this.$el.find('script').siblings();

    $textarea.val('');
    $mentions.html('');
  }

  create(data) {
    APIUtil.createTweet(data)
      .then(res => this.handleSuccess(res));
  }

  handleCharsLeft(e) {
    const chars = e.currentTarget.value;
    const charLength = chars.length;
    const $char = $('.chars-left');

    this.renderCharsLeft($char, charLength);
  }

  children() {
    return this.$el.children();
  }

  disable() {
    this.children().each( (idx, child) => {
      $(child).prop('disabled', true);
    });
  }

  enable() {
    this.children().each( (idx, child) => {
      $(child).prop('disabled', false);
    });
  }

  handleSuccess(res) {
    this.clearInput();
    this.enable();
    const $li = TweetUtil.generateTweetListItem(res);
    this.$feed.prepend($li);
  }

  removeMentionedUser(e) {
    e.preventDefault();
    const $link = $(e.currentTarget);
    const $div = $link.parent();
    $div.html('');
  }

  renderCharsLeft($char, charLength) {
    if (charLength > 0 && charLength <= 140) {
      const remaining = 140 - charLength;
      $char.text(`${remaining} characters left!`);
    } else if (charLength > 140) {
      $char.text(`${charLength - 140} characters above max length!`);
    } else {
      $char.text('');
    }
  }

  submit(e) {
    e.preventDefault();
    const $form = $(e.currentTarget);
    const data = $form.serialize();

    this.disable();
    this.create(data);
  }
}

module.exports = TweetCompose;
