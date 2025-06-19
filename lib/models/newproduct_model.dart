class Product {
  final String id;
  final String title;
  final String image;
  final double price;
  final String? description;
  final double ratings;
  // final int currentStep;


  Product({required this.title, required this.image, required this.price,this.description,required this.ratings,required this.id, });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['product_title'] ?? 'No Title',
      image: json['product_photo'] ?? '',
      price: _parsePrice(json['product_price']),
      id:json['asin'],
      description: json['description']?? '',
      ratings:  _parseRating(json['product_star_rating']),
      // currentStep: json['currentStep'],
    );
  }
  //function to convert string into double.
  static double _parsePrice(dynamic priceString){

    if(priceString ==null) return 0.0;
    try{
      String cleaned = priceString.toString().replaceAll('\$', '').replaceAll(',', '');
      return double.tryParse(cleaned) ?? 0.0;
    }catch (e){
      return 0.0;
    }

  }

  static double _parseRating(dynamic ratingString) {
    if (ratingString == null) return 0.0;
    try {
      return double.tryParse(ratingString.toString()) ?? 0.0;
    } catch (e) {
      return 0.0;
    }
  }
}