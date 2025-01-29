enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  searchRoute("/search"),
  addRoute("/add");

  const NavigationRoute(this.name);
  final String name;
}
