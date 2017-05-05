const MessageStore = require('./message_store');

const Compose = {
  render: function() {
    const div = document.createElement('div');
    div.className = 'new-message';
    div.innerHTML = this.renderForm();

    div.addEventListener('change',event => {
      const el = event.target;
      MessageStore.updateDraftField(el.name, el.value);
    });

    div.addEventListener('submit',event => {
      event.preventDefault();
      MessageStore.sendDraft();
      window.location.hash = 'inbox';
    });
    return div;
  },

  renderForm: function() {
    let currDraft = MessageStore.getMessageDraft();

    return (
      `
        <p class="new-message-header">New Message</p>
        <form class="compose-form">
        <input type="text" name="to" value="${currDraft.to}"
        placeholder="Recipient">

        <input type="text" name="subject" value="${currDraft.subject}"
        placeholder="Subject">


        <textarea name="body" rows="20">${currDraft.body}</textarea>

        <button type="submit" class="btn btn-primary submit-message">
        Send
        </button>

      </form>
      `
    );

  }
};

module.exports = Compose;
