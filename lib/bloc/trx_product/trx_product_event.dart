part of 'trx_product_bloc.dart';

@freezed
class TrxProductEvent with _$TrxProductEvent {
  const factory TrxProductEvent.started() = _Started;
  const factory TrxProductEvent.trxProduct(TrxProductRequestModel model) =
      _TrxProduct;
  const factory TrxProductEvent.getTrx(String id) = _GetTrx;
  const factory TrxProductEvent.getAll(String status) = _GetAll;
}
