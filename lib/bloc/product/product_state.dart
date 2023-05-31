part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({
    required this.status,
    this.products = const [],
  });

  final Status status;
  final List<ProductModel> products;

  ProductState copyWith({
    Status? status,
    List<ProductModel>? products,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
    );
  }

  @override
  List<Object> get props => [
        status,
        products,
      ];
}
