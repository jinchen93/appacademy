const DOMNodeCollection = require('./dom_node_collection');

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
