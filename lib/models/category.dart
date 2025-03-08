class Category {
  final String name;
  final String imageUrl;
  final int productCount;

  Category({
    required this.name,
    required this.imageUrl,
    required this.productCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      imageUrl: json['imageUrl'],
      productCount: json['productCount'],
    );
  }
}
