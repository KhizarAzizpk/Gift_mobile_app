import 'package:cloud_firestore/cloud_firestore.dart';

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
  int currentStep;
  final int quantity;

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
    required this.quantity,
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
      'timestamp': Timestamp.fromDate(timestamp), // Save as Firestore Timestamp
      'currentStep': currentStep,
      'quantity': quantity,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final timestampRaw = json['timestamp'];

    DateTime parsedTimestamp;
    if (timestampRaw is Timestamp) {
      parsedTimestamp = timestampRaw.toDate();
    } else if (timestampRaw is String) {
      parsedTimestamp = DateTime.tryParse(timestampRaw) ?? DateTime.now();
    } else {
      parsedTimestamp = DateTime.now(); // fallback
    }

    return OrderModel(
      orderId: json['orderId'],
      productId: json['productId'],
      title: json['title'],
      image: json['image'],
      price: (json['price'] as num).toDouble(),
      ratings: (json['ratings'] as num).toDouble(),
      description: json['description'],
      isCompleted: json['isCompleted'] ?? false,
      timestamp: parsedTimestamp,
      currentStep: json['currentStep'] ?? 0,
      quantity: json['quantity'] ?? 1,
    );
  }

  OrderModel copyWith({
    String? orderId,
    String? productId,
    String? title,
    String? image,
    double? price,
    double? ratings,
    String? description,
    bool? isCompleted,
    DateTime? timestamp,
    int? currentStep,
    int? quantity,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      ratings: ratings ?? this.ratings,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      timestamp: timestamp ?? this.timestamp,
      currentStep: currentStep ?? this.currentStep,
      quantity: quantity ?? this.quantity,
    );
  }
}
