const Router = require('./router');
const Inbox = require('./inbox');
const Sent = require('./sent');
const Compose = require('./compose');

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
