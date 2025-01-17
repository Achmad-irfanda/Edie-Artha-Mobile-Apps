import 'package:bloc/bloc.dart';
import 'package:eam_app/data/datasource/auth_remote_datasource.dart';
import 'package:eam_app/data/models/request/register_request_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/response/auth_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';
part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(_Initial()) {
    on<_Register>((event, emit) async {
      emit(_Loading());
      final result = await AuthRemoteDatasource().register(event.model);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });
  }
}
