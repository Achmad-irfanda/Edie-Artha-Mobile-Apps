part of 'trx_bengkel_bloc.dart';

@freezed
class TrxBengkelState with _$TrxBengkelState {
  const factory TrxBengkelState.initial() = _Initial;
  const factory TrxBengkelState.loading() = _Loading;
  const factory TrxBengkelState.loaded(TrxBengkelResponseModel data) = _Loaded;
  const factory TrxBengkelState.error(String message) = _Error;
}
