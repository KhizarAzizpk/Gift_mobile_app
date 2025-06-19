import 'package:get/get.dart';
import 'package:gift_mobile_app/models/cart_model.dart';
import 'package:gift_mobile_app/models/category_model.dart';
import 'package:gift_mobile_app/models/product_model.dart';
import 'package:gift_mobile_app/models/user_model.dart';
import 'package:gift_mobile_app/utils/utils.dart';

var token = ''.obs;
var userId = ''.obs;
String userCollection = 'users';
double width = Get.width;
double height = Get.height;

// local api endpoint for mobile
// String baseUrl = 'http://192.168.0.106:8080';

// local api endpoint for emulator
String baseUrl = 'http://10.0.2.2:3000';

var userModelGlobal = UserModel(
  uid: '',
  userName: '',
  email: '',
  phoneNumber: '',
  profileImageUrl: '',
  gender: '',
  dateOfBirth: '',
  address: '',
  createdAt: DateTime.now().toString(),
  subProfilesList: [],
  selectedCountry: '',
).obs;

List<CategoryModel> categories = [
  CategoryModel(iconPath: Assets.assetsIconsCarIcon, name: AppString.cars),
  CategoryModel(iconPath: Assets.assetsIconsDollIcon, name: AppString.dolls),
  CategoryModel(
      iconPath: Assets.assetsIconsRockerIcon, name: AppString.rockers),
  CategoryModel(iconPath: Assets.assetsIconsFrockIcon, name: AppString.frock),
  CategoryModel(iconPath: Assets.assetsIconsMakeupIcon, name: AppString.makeup),
];

List<String> popularCat = [
  AppString.all,
  AppString.deals,
  AppString.topSeller,
  AppString.newArrival,
  AppString.greatFriday,
];

List<ProductModel> productList = [
  ProductModel(
      imagePath: Assets.assetsImagesCarGiftImage,
      name: AppString.diecastMcQueenCar,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesHouseGiftImage,
      name: AppString.musicalLivingHouse,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesToysImage,
      name: AppString.musicalCuteCocomelonDoll,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesToyImage,
      name: AppString.superKidsArcherySet,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesWalkerImage,
      name: AppString.infantesTravelBabyStroller,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesCarGiftImage,
      name: AppString.diecastMcQueenCar,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesHouseGiftImage,
      name: AppString.musicalLivingHouse,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesToysImage,
      name: AppString.musicalCuteCocomelonDoll,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesToyImage,
      name: AppString.superKidsArcherySet,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
  ProductModel(
      imagePath: Assets.assetsImagesWalkerImage,
      name: AppString.infantesTravelBabyStroller,
      rating: AppString.rating,
      soldcount: AppString.soldcount),
];

//Cart List
// List<CartModel> cartList = [
//   CartModel(
//     id: '345',
//     imagePath: Assets.assetsImagesCarGiftImage,
//     title: AppString.diecastMcQueenCar,
//     colorIconPath: Assets.assetsIconsGrayColorIcon,
//     color: AppString.color,
//     count: 1,
//     rating: 4.5,
//   ),
//   CartModel(
//     id: '325',
//     imagePath: Assets.assetsImagesToysImage,
//     title: AppString.musicalCuteCocomelonDoll,
//     colorIconPath: Assets.assetsIconsBrownColorIcon,
//     color: AppString.color,
//     count: 2,
//     rating: 4.7,
//   ),
//   CartModel(
//     id: '465',
//     imagePath: Assets.assetsImagesToyImage,
//     title: AppString.superKidsArcherySet,
//     colorIconPath: Assets.assetsIconsBlackColorIcon,
//     color: AppString.color,
//     count: 3,
//     rating: 4.6,
//   ),
//   CartModel(
//     id: '235',
//     imagePath: Assets.assetsImagesCarGiftImage,
//     title: AppString.diecastMcQueenCar,
//     colorIconPath: Assets.assetsIconsGrayColorIcon,
//     color: AppString.color,
//     count: 1,
//     rating: 4.5,
//   ),
//   CartModel(
//     id: '341',
//     imagePath: Assets.assetsImagesToysImage,
//     title: AppString.musicalCuteCocomelonDoll,
//     colorIconPath: Assets.assetsIconsBrownColorIcon,
//     color: AppString.color,
//     count: 2,
//     rating: 4.7,
//   ),
//   CartModel(
//     id: '225',
//     imagePath: Assets.assetsImagesToyImage,
//     title: AppString.superKidsArcherySet,
//     colorIconPath: Assets.assetsIconsBlackColorIcon,
//     color: AppString.color,
//     count: 3,
//     rating: 4.6,
//   ),
// ];
