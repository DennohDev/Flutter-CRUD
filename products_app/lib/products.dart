
class Product {
  String id;
  String name;
  String qty;
  String price;
  String description;

  Product({
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
    required this.description,
     });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      name: json['name'].toString(),
      qty: json['qty'].toString(),
      price: json['price'].toString(),
      description: json['description'].toString(),

    );
  }
}