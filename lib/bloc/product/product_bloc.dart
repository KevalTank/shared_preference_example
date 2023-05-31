import 'dart:async';

import 'package:demaze/constants/status.dart';
import 'package:demaze/general/show_toast.dart';
import 'package:demaze/local_storage/shared_pref.dart';
import 'package:demaze/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'product_event.dart';

part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required SharedPrefHelper helper,
  })  : _helper = helper,
        super(const ProductState(status: Status.initial, products: [])) {
    on<SaveProductDetailsRequested>(_onSaveProductDetailsRequested);
    on<GetProductDetailsFromPreferencesRequested>(
        _onGetProductDetailsFromPreferencesRequested);
    on<EditProductDetailsRequested>(_onEditProductDetailsRequested);
  }

  late List<ProductModel> _products;
  final SharedPrefHelper _helper;

  FutureOr<void> _onSaveProductDetailsRequested(
    SaveProductDetailsRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    final product = ProductModel(
      id: const Uuid().v4(),
      productName: event.productName,
      productDescription: event.productDescription,
      createdTime: DateTime.now(),
    );
    _helper.addProduct(productModel: product);
    _products.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    showToast(message: 'Product added successfully');
    emit(state.copyWith(
      status: Status.success,
      products: _products,
    ));
  }

  FutureOr<void> _onGetProductDetailsFromPreferencesRequested(
    GetProductDetailsFromPreferencesRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    _products = await _helper.getProducts();
    _products.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    emit(state.copyWith(status: Status.success, products: _products));
  }

  FutureOr<void> _onEditProductDetailsRequested(
    EditProductDetailsRequested event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    await _helper.editProduct(
      productId: event.productModel.id,
      productModel: event.productModel,
    );
    _products = await _helper.getProducts();
    _products.sort((a, b) => b.createdTime.compareTo(a.createdTime));
    showToast(message: 'Product edited successfully');
    emit(state.copyWith(status: Status.success, products: _products));
  }
}
