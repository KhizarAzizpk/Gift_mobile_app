class OrderModel {
  final String orderId;
  final String productId;
  final String title;
  final String image;
  final double price;
  final double ratings;
  final String? description;
  final bool isCompleted;
  final DateTime timestamp;
          int  currentStep;
  // final int quantity;

  OrderModel({
    required this.orderId,
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.ratings,
    this.description,
    required this.isCompleted,
    required this.timestamp,
    required this.currentStep,
    // required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'title': title,
      'image': image,
      'price': price,
      'ratings': ratings,
      'description': description,
      'isCompleted': isCompleted,
      'timestamp': timestamp.toIso8601String(),
      'currentStep':currentStep,
      // 'quantity' :quantity,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'],
      productId: json['productId'],
      title: json['title'],
      image: json['image'],
      price: json['price'],
      ratings: json['ratings'],
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
      timestamp: DateTime.parse(json['timestamp']),
      currentStep: json['currentStep']?? 0,
      // quantity: json['quantity'],
    );
  }

  OrderModel copyWith({bool? isCompleted,  int? currentStep}) {
    return OrderModel(
      orderId: orderId,
      productId: productId,
      title: title,
      image: image,
      price: price,
      ratings: ratings,
      description: description,
      isCompleted: isCompleted ?? this.isCompleted,
      timestamp: timestamp,
      currentStep: currentStep?? this.currentStep,
      // quantity: quantity,
    );
  }


}
