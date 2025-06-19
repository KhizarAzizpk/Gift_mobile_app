import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gift_mobile_app/utils/utils.dart';
import 'package:gift_mobile_app/views/generated%20gift%20screen/product_detail_screen.dart';
import 'package:gift_mobile_app/widgets/widgets.dart';

import '../../core/services/fetching_category.dart';
import '../../models/newproduct_model.dart';

class GeneratedGiftScreen extends StatefulWidget {
  @override
  _GeneratedGiftScreenState createState() => _GeneratedGiftScreenState();
}

class _GeneratedGiftScreenState extends State<GeneratedGiftScreen> {
  late List<Product> _products;
  late int _currentPage;
  late bool _isLoading;
  late ScrollController _scrollController;
  late String? interested;
  late String? notInterested;
  late String? theme;
  late String? occasion;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments as Map<String, dynamic>;
    interested = args['interested'];
    notInterested = args['notInterested'];
    theme = args['theme'];
    occasion = args['occasion'];

    _products = [];
    _currentPage = 1;
    _isLoading = false;
    _scrollController = ScrollController();
    _loadMoreProducts();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent &&
          _products.length < 5) {
        _loadMoreProducts();
      }
    });
  }

  Future<void> _loadMoreProducts() async {
    if (_isLoading || _products.length >= 5) return;

    setState(() {
      _isLoading = true;
    });

    try {

      final newProducts = await AmazonService.fetchProducts(
        page: _currentPage,
        interested: interested,
        notInterested: notInterested,
        theme: theme,
        occasion: occasion,
      );

      final remaining = 5 - _products.length;
      final limitedProducts = newProducts.take(remaining).toList();

      setState(() {
        _products.addAll(limitedProducts);
        _currentPage++;
        _isLoading = false;
      });
    } catch (e,stackTrace) {
      debugPrint('Error loading products: $e');
      debugPrint('Stack trace: $stackTrace');
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load more products')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_products.isEmpty && _isLoading) {
      return Scaffold(
        appBar: CustomAppBar(
          title: AppString.giftforkids,
          titleStyle: AppStyle.urbanistBold24Black,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: AppString.giftforkids,
        titleStyle: AppStyle.urbanistBold24Black,
      ),
      body: GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: _products.length + (_isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _products.length) {
            return Center(child: CircularProgressIndicator());
          }

          final product = _products[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
                    );
                    print("hereee is the ${product.id}");
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                    child: Image.network(
                      product.image,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '\$${double.tryParse(product.price.toString())?.toStringAsFixed(2) ?? 'N/A'}',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
