part of 'trx_product_bloc.dart';

@freezed
class TrxProductState with _$TrxProductState {
  const factory TrxProductState.initial() = _Initial;
  const factory TrxProductState.loading() = _Loading;
  const factory TrxProductState.loaded(TrxProductResponse data) = _Loaded;
  const factory TrxProductState.error(String message) = _Error;
}
