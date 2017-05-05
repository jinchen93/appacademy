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
