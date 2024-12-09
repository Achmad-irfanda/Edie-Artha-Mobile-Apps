part of 'trx_bengkel_bloc.dart';

@freezed
class TrxBengkelEvent with _$TrxBengkelEvent {
  const factory TrxBengkelEvent.started() = _Started;
  const factory TrxBengkelEvent.getAll(String status) = _GetAll;
}
