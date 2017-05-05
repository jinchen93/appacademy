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
