import 'package:bloc/bloc.dart';
import 'package:eam_app/data/datasource/product_remote_datasource.dart';
import 'package:eam_app/data/models/request/trx_product_request_model.dart';
import 'package:eam_app/data/models/response/trx_product_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trx_product_event.dart';
part 'trx_product_state.dart';
part 'trx_product_bloc.freezed.dart';

class TrxProductBloc extends Bloc<TrxProductEvent, TrxProductState> {
  TrxProductBloc() : super(_Initial()) {
    on<_TrxProduct>((event, emit) async {
      emit(_Loading());
      final result = await ProductRemoteDatasource().transaction(event.model);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    on<_GetTrx>((event, emit) async {
      emit(_Loading());
      final result = await ProductRemoteDatasource().getTrx(event.id);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    on<_GetAll>((event, emit) async {
      emit(_Loading());
      final result = await ProductRemoteDatasource().getAll(event.status);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
