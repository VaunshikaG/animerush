import 'package:get/get.dart';

import '../utils/ApiProviders.dart';

class Search_Controller extends GetxController {
  final ApiProviders _apiProviders = ApiProviders();
  RxBool isTyping = false.obs;

  List<String> searchHistory = [];
  String categoryType = "", genreType = "", value1 = "", value2 = "";


}