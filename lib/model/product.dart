class Product {
  String id; // ID sản phẩm
  String brand;
  String category;
  String description;
  String picture;
  String name;
  bool offer;
  double price;

  Product({
    required this.id,
    required this.brand,
    required this.category,
    required this.description,
    required this.picture,
    required this.name,
    required this.offer,
    required this.price,
  });

  // Tạo Product từ Map (dùng khi lấy dữ liệu từ Firebase)
  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      brand: map['brand'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      picture: map['picture'] ?? '',
      name: map['name'] ?? '',
      offer: map['offer'] ?? false,
      price: (map['price'] ?? 0).toDouble(),
    );
  }

  // Chuyển Product thành Map (dùng khi ghi dữ liệu lên Firebase)
  Map<String, dynamic> toMap() {
    return {
      'brand': brand,
      'category': category,
      'description': description,
      'picture': picture,
      'name': name,
      'offer': offer,
      'price': price,
    };
  }
}
