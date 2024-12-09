part of 'bengkel_bloc.dart';

@freezed
class BengkelState with _$BengkelState {
  const factory BengkelState.initial() = _Initial;
  const factory BengkelState.loading() = _Loading;
  const factory BengkelState.loaded(BengkelResponseModel data) = _Loaded;
  const factory BengkelState.error(String message) = _Error;
}
