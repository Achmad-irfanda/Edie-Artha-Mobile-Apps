import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/datasource/bengkel_remote_datesource.dart';
import '../../data/models/response/trx_bengkel_response_model.dart';

part 'trx_bengkel_event.dart';
part 'trx_bengkel_state.dart';
part 'trx_bengkel_bloc.freezed.dart';

class TrxBengkelBloc extends Bloc<TrxBengkelEvent, TrxBengkelState> {
  TrxBengkelBloc() : super(_Initial()) {
    on<_GetAll>((event, emit) async {
      emit(_Loading());
      final result = await BengkelRemoteDatesource().getAll(event.status);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
