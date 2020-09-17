class ListItem {
  // field
  String name;
  String brand;
  int quantity;
  bool favorite;

  // ignore: non_constant_identifier_names
  Users(String name, String brand, int quantity, bool favorite) {
    this.name = name;
    this.brand = brand;
    this.quantity = quantity;
    this.favorite = favorite;
  }
}
