class Product {
  int id;
  String title;
  String description;
  String category;
  double price;
  double discountPercentage;
  double rating;
  int stock;
  String brand;
  String thumbnail;
  List<dynamic> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.brand,
    required this.thumbnail,
    required this.images,
  });

  factory Product.fromMap(Map<String, dynamic> data) => Product(
      id: data['id'],
      title: data['title'],
      description: data['description'],
      category: data['category'],
      price: double.parse(data['price'].toString()),
      discountPercentage: double.parse(data['discountPercentage'] == null
          ? "0"
          : data['discountPercentage'].toString()),
      rating: double.parse(data['rating'].toString()),
      stock: data['stock'],
      brand: data['brand'],
      thumbnail: data['thumbnail'],
      images: ['images']);

  Map<String, dynamic> toMap() => {
        // 'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'brand': brand,
        'thumbnail': thumbnail,
        'images': images
      };
}
