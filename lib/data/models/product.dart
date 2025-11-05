import 'dart:convert';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: (map['id'] as num).toInt(),
      title: map['title'] ?? '',
      price: (map['price'] as num).toDouble(),
      description: map['description'] ?? '',
      image: map['image'] ?? '',
    );
  }

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
    };
  }
}
