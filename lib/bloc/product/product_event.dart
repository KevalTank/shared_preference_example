part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class SaveProductDetailsRequested extends ProductEvent {
  const SaveProductDetailsRequested({
    required this.productName,
    required this.productDescription,
  });

  final String productName;
  final String productDescription;
}

class GetProductDetailsFromPreferencesRequested extends ProductEvent {}

class EditProductDetailsRequested extends ProductEvent {
  const EditProductDetailsRequested({
    required this.productModel,
  });

  final ProductModel productModel;
}
