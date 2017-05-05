/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// identity function for calling harmony imports with the correct context
/******/ 	__webpack_require__.i = function(value) { return value; };
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const Router = __webpack_require__(1);
const Inbox = __webpack_require__(2);
const Sent = __webpack_require__(4);
const Compose = __webpack_require__(5);

const routes = {
  compose: Compose,
  sent: Sent,
  inbox: Inbox
};

document.addEventListener('DOMContentLoaded', function() {
  document.querySelectorAll('.sidebar-nav li').forEach(li => {
    li.addEventListener('click', event=> {
      const ele = event.currentTarget;
      const location = ele.innerText.toLowerCase();
      window.location.hash = location;
    });
  });

  const node = document.querySelector('.content');
  const router = new Router(node, routes);
  router.start();
  window.location.hash = 'inbox';
});


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    window.addEventListener('hashchange', this.render.bind(this));
  }

  render() {
    this.node.innerHTML = "";
    const component = this.activeRoute();
    this.node.innerHTML = '';

    if (component !== undefined) {
      const node = component.render();
      this.node.appendChild(node);
    }
  }

  activeRoute(){
    const hashFragment = window.location.hash.slice(1);
    return this.routes[hashFragment];
  }
}

module.exports = Router;


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

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


/***/ }),
/* 3 */
/***/ (function(module, exports) {

let messages = {
  sent: [
    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
    {to: "person@mail.com", subject: "zzz", body: "so booring"}
  ],
  inbox: [
    {
      from: "grandma@mail.com",
      subject: "Fwd: Fwd: Fwd: Check this out",
      body: "Stay at home mom discovers cure for leg cramps. Doctors hate her"
    },

    {
      from: "person@mail.com",
      subject: "Questionnaire",
      body: "Take this free quiz win $1000 dollars"
    }
  ]
};

const MessageStore = {
  getInboxMessages: function() {
    return messages.inbox;
  },
  getSentMessages: function() {
    return messages.sent;
  },
  updateDraftField: function(field, value) {
    messageDraft[field] = value;
  },
  sendDraft: function() {
    messages.sent.push(messageDraft);
    messageDraft = new Message('','','','');
  },
  getMessageDraft: function() {
    return messageDraft;
  }
};


class Message {
  constructor(from, to, subject, body) {
    this.from = from;
    this.to = to;
    this.subject = subject;
    this.body = body;
  }
}

let messageDraft = new Message('','','','');


module.exports = MessageStore;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

const Sent = {
  render: function() {
    const ul = document.createElement('ul');
    ul.className  = 'messages';
    MessageStore.getSentMessages().forEach(message => {
      const messageNode = this.renderMessage(message);
      ul.appendChild(messageNode);
    });

    return ul;
  },

  renderMessage: function(message) {
    const li = document.createElement('li');
    li.className = 'message';
    const toSpan = document.createElement('span');
    toSpan.className = 'to';
    toSpan.innerHTML = message.to;
    li.appendChild(toSpan);

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

module.exports = Sent;


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(3);

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


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map