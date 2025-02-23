enum NavigationRoute {
  mainRoute("/main"),
  detailRoute("/detail"),
  searchRoute("/search"),
  addRoute("/add"),
  favoriteRoute("/favorite"),
  moreRoute("/more");

  const NavigationRoute(this.name);
  final String name;
}
