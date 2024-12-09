part of 'bengkel_bloc.dart';

@freezed
class BengkelEvent with _$BengkelEvent {
  const factory BengkelEvent.started() = _Started;
  const factory BengkelEvent.bengkel(BengkelRequestModel model) = _Bengkel;
  const factory BengkelEvent.getTrx(String id) = _GetTrx;
}
