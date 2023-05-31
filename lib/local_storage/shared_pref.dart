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

  Future<void> addProduct({required ProductModel productModel}) async {
    _productList.add(productModel);
    final productListJson =
        _productList.map((product) => product.toJson()).toList();
    await _prefs?.setString(
        SharedPrefConstants.keyProducts, jsonEncode(productListJson));
  }

  Future<List<ProductModel>> getProducts() async {
    if (_prefs == null) {
      await _initPrefs();
    }
    final productListJson = _prefs?.getString(SharedPrefConstants.keyProducts);
    if (productListJson != null) {
      final productList = jsonDecode(productListJson);
      _productList = productList
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList()
          .cast<ProductModel>();
    }
    return _productList;
  }

  Future<void> editProduct({
    required String productId,
    required ProductModel productModel,
  }) async {
    final productIndex =
        _productList.indexWhere((product) => product.id == productId);
    if (productIndex != -1) {
      _productList[productIndex] = productModel;
      final productListJson =
          _productList.map((product) => product.toJson()).toList();
      await _prefs?.setString(
          SharedPrefConstants.keyProducts, jsonEncode(productListJson));
    }
  }

  Future<void> saveTheme(AppTheme theme) async {
    await _prefs?.setString(SharedPrefConstants.keyTheme, theme.toString());
  }

  Future<AppTheme> getTheme() async {
    final themeString = _prefs?.getString(SharedPrefConstants.keyTheme);
    if (themeString != null) {
      return AppTheme.values.firstWhere((e) => e.toString() == themeString);
    }
    return AppTheme.dark;
  }
}
