part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.started() = _Started;
  const factory ProductEvent.product() = _Product;
  const factory ProductEvent.getProduct(String query) = _GetProduct;
}
