const MessageStore = require('./message_store');

const Inbox = {
  render: function() {
    const ul = document.createElement('ul');
    ul.className  = 'messages';
    MessageStore.getInboxMessages().forEach(message => {
      const messageNode = this.renderMessage(message);
      ul.appendChild(messageNode);
    });

    return ul;
  },

  renderMessage: function(message) {
    const li = document.createElement('li');
    li.className = 'message';
    const fromSpan = document.createElement('span');
    fromSpan.className = 'from';
    fromSpan.innerHTML = message.from;
    li.appendChild(fromSpan);

    const subjectSpan = document.createElement('span');
    subjectSpan.className = 'subject';
    subjectSpan.innerHTML = message.subject + " - ";
    li.appendChild(subjectSpan);

    const bodySpan = document.createElement('span');
    bodySpan.className = 'body';
    bodySpan.innerHTML = message.body;
    li.appendChild(bodySpan);

    return li;
  }
};

module.exports = Inbox;
