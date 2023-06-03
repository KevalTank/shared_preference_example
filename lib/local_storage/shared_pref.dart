import 'dart:convert';

import 'package:demaze/constants/color_constants.dart';
import 'package:demaze/constants/pref_constants.dart';
import 'package:demaze/model/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static final SharedPrefHelper _instance = SharedPrefHelper._internal();

  SharedPrefHelper._internal() {
    _initPrefs();
  }

  factory SharedPrefHelper() {
    return _instance;
  }

  SharedPreferences? _prefs;

  List<ProductModel> _productList = [];

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Add product to the preferences
  Future<void> addProduct({
    required ProductModel productModel,
  }) async {
    // Add the product to the list
    _productList.add(productModel);
    // Convert the list into json
    final productListJson =
        _productList.map((product) => product.toJson()).toList();
    // Save list to the preferences
    await _prefs?.setString(
        SharedPrefConstants.keyProducts, jsonEncode(productListJson));
  }

  // Get products from the preferences
  Future<List<ProductModel>> getProducts() async {
    // Check if preference's instance is initialized or not? if not then initialize it
    if (_prefs == null) {
      await _initPrefs();
    }
    // Get list of products in json format
    final productListJson = _prefs?.getString(SharedPrefConstants.keyProducts);
    // Check if received list is empty or not?
    if (productListJson != null) {
      // If product list is not empty then convert it to the product model
      final productList = jsonDecode(productListJson);
      _productList = productList
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList()
          .cast<ProductModel>();
    }
    // Return product list
    return _productList;
  }

  Future<void> editProduct({
    required String productId,
    required ProductModel productModel,
  }) async {
    // Find index of the received product in the preferences
    final productIndex =
        _productList.indexWhere((product) => product.id == productId);
    // If received product is present in the the preference list then edit it
    if (productIndex != -1) {
      // Override the product model into the list
      _productList[productIndex] = productModel;
      // Convert list of products to the json format
      final productListJson =
          _productList.map((product) => product.toJson()).toList();
      // save the list to the preferences
      await _prefs?.setString(
          SharedPrefConstants.keyProducts, jsonEncode(productListJson));
    }
  }

  // Save the theme to the preferences
  Future<void> saveTheme(AppTheme theme) async {
    await _prefs?.setString(SharedPrefConstants.keyTheme, theme.toString());
  }

  // Get the theme from the preferences
  Future<AppTheme> getTheme() async {
    // Get the theme from the preferences
    final themeString = _prefs?.getString(SharedPrefConstants.keyTheme);
    // If saved theme is not null then return
    if (themeString != null) {
      return AppTheme.values.firstWhere((e) => e.toString() == themeString);
    }
    // If preference's do not have the theme then return dark theme
    return AppTheme.dark;
  }
}
