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

const DOMNodeCollection = __webpack_require__(1);

function $l(arg) {
  let eleArray;
  if (arg instanceof HTMLElement) {
    eleArray = [HTMLElement];
  } else if (arg instanceof Function) {
    if (document.readyState === 'complete') {
      arg.call(window);
    } else {
      alert('not yet loaded!');
      document.addEventListener('DOMContentLoaded', arg);
    }
  } else {
    eleArray = Array.from(document.querySelectorAll(arg));
  }

  return new DOMNodeCollection(eleArray);
}


$l.extend = function(objA, ...objects) {
  objects.forEach(obj => {
    for (let key in obj) {
      objA[key] = obj[key];
    }
  });

  return objA;
};


$l.ajax = function(options) {
  const defaults = {
    method: 'GET',
    url: '',
    data: {},
    contentType: 'json',
    success: data => console.log(data),
    error: err => console.log(err)
  };

  $l.extend(defaults, options);

  const xhr = new XMLHttpRequest();
  xhr.open(defaults.method, defaults.url);
  xhr.setRequestHeader("Accept", defaults.contentType);
  xhr.onload = function() {
    let res = JSON.parse(xhr.response);
    if (xhr.status === 200) {
      defaults.success(res);
    } else {
      defaults.error(res);
    }
  };

  xhr.send(defaults.data);
};
$l.ajax({
  type: 'GET',
  url: "http://api.openweathermap.org/data/2.5/weather?q=NY,NY,uk&appid=bcb83c4b54aee8418983c2aff3073b3b",
  success(data) {
    console.log("We have your weather!")
    console.log(data);
  },
  error() {
    console.error("An error occurred.");
  },
});

window.$l = $l;


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(elements) {
    this.elements = elements;
  }

  html(string) {
    if (string !== undefined) {
      this.each(ele => {
        ele.innerHTML = string;
      });
      return this.elements;
    } else {
      return this.elements[0].innerHTML;
    }
  }

  appendHTML(html){
    this.each(el => {
      el.innerHTML += html;
    });
  }

  empty() {
    this.html("");
  }


  addClass(string) {
    this.each( ele => {
      ele.classList.add(string);
    });
  }

  attr(string, val) {
    if (val === undefined) {
      return this.elements[0].getAttribute(string);
    } else {
      this.each( ele => {
        ele.setAttribute(string, val);
      });
      return this.elements;
    }
  }

  append(arg) {
    if (arg instanceof DOMNodeCollection) {
      arg.each(node => {
        this.appendHTML(node.outerHTML);
      });
    } else if (arg instanceof HTMLElement) {
      this.appendHTML(arg.outerHTML);
    } else if (typeof(arg) === 'string'){
      this.appendHTML(arg);
    }
  }

  children() {
    let childrenArr = [];
    this.each(ele => {
      childrenArr = childrenArr.concat(Array.from(ele.children));
    });
    return new DOMNodeCollection(childrenArr);
  }

  each(callback) {
    for (let i = this.elements.length - 1; i > -1; i--) {
      callback(this.elements[i]);
    }
  }

  find(selector) {
    let found = [];
    this.each(ele => {
      let foundEl = ele.querySelectorAll(selector);
      found = found.concat(Array.from(foundEl));
    });

    return new DOMNodeCollection(found);
  }

  off(eventString) {
    this.each( el => {
      el.removeEventListener(eventString, el.listenerCallback);
    });
  }

  on(eventString, callback) {
    this.each( el => {
      el.listenerCallback = callback;
      el.addEventListener(eventString, callback);
    });
  }

  parent() {
    let parentArr = [];
    this.each(ele => {
      if (!parentArr.includes(ele.parentNode)) {
        parentArr.push(ele.parentNode);
      }
    });

    return new DOMNodeCollection(parentArr);
  }

  remove() {
    this.each(ele => ele.remove());
    this.elements = [];
  }

  removeClass(string) {
    this.each( ele => {
      if (string === undefined) {
        ele.setAttribute('class', '');
      } else {
        ele.classList.remove(string);
      }
    });
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);
//# sourceMappingURL=jquerylite.js.map