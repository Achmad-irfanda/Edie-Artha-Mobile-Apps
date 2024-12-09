import 'package:bloc/bloc.dart';
import 'package:eam_app/data/datasource/bengkel_remote_datesource.dart';
import 'package:eam_app/data/models/request/bengkel_request_model.dart';
import 'package:eam_app/data/models/response/bengkel_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bengkel_event.dart';
part 'bengkel_state.dart';
part 'bengkel_bloc.freezed.dart';

class BengkelBloc extends Bloc<BengkelEvent, BengkelState> {
  BengkelBloc() : super(_Initial()) {
    on<_Bengkel>((event, emit) async {
      emit(_Loading());
      final result = await BengkelRemoteDatesource().transaction(event.model);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    on<_GetTrx>((event, emit) async {
      emit(_Loading());
      final result = await BengkelRemoteDatesource().getTrx(event.id);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
