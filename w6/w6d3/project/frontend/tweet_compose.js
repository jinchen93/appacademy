const APIUtil = require('./api_util');

class TweetCompose {
  constructor($el) {
    this.$el = $el;
    this.$feed = this.findFeed();
    this.bindEvents();
  }

  bindEvents() {
    this.$el.on('submit', e => this.submit(e));
    this.$el.find('textarea').on('input', e => this.handleCharsLeft(e));
  }

  clearInput() {
    const $textarea = this.$el.find('textarea');
    const $mention = this.$el.find('select');

    $textarea.val('');
    $mention.val('');
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

  findFeed() {
    const feed = this.$el.data('tweets-ul');
    return $(feed);
  }

  generateTweetListItem(res) {
    const $li = $('<li></li>');
    $li.append(res.content + ' -- ');
    $li.append($(`<a href="/users/${res.user_id}">${res.user.username}</a> `));
    $li.append(`-- ${res.created_at}`);
    $li.append(this.renderMentions(res.mentions));
    return $li;
  }

  handleSuccess(res) {
    this.clearInput();
    this.enable();
    const $li = this.generateTweetListItem(res);
    console.log(res);
    this.$feed.prepend($li);
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

  renderMentions(mentions) {
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
