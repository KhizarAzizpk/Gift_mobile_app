class FavoriteModel {
  String id;
  String title;
  String image;
  double price;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  // Convert from Firestore map
  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      image: map['image'] ?? '',
      price: (map['price'] ?? 0).toDouble(), // ✅ Fix: should be `toDouble()`, not `todouble()`
    );
  }

  // Convert to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
    };
  }
}
