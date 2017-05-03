/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
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

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const TweetCompose = __webpack_require__(4);

$( () => {
  const $allFollowBtns = $('.follow-toggle');
  $allFollowBtns.each( (idx, btn) => {
    new FollowToggle($(btn));
  });

  let $userSearch = $('nav.users-search');
  new UsersSearch($userSearch);
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class FollowToggle {
  constructor($el, options) {
    this.$el = $el;
    this.userId = $el.data('user-id') || options.userId;
    this.followState = $el.data('initial-follow-state') || options.followState;
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


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: 'JSON'
    })
  ),

  unfollowUser: id => (
    $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'JSON'
    })
  ),

  searchUsers: queryVal => (
    $.ajax({
      url: '/users/search',
      data: { query: queryVal },
      dataType: 'JSON'
    })
  )

};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

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


/***/ }),
/* 4 */
/***/ (function(module, exports) {

class TweetCompose {
  constructor($el) {
    this.$el = $el;
  }
}

module.exports = TweetCompose;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map