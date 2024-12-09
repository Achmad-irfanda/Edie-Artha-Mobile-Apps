import 'package:bloc/bloc.dart';
import 'package:eam_app/data/datasource/auth_remote_datasource.dart';
import 'package:eam_app/data/models/request/user_request_model.dart';
import 'package:eam_app/data/models/response/user_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_event.dart';
part 'user_state.dart';
part 'user_bloc.freezed.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(_Initial()) {
    // Get User
    on<_User>((event, emit) async {
      emit(_Loading());
      final result = await AuthRemoteDatasource().getUser();
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    // Update User
    on<_Update>((event, emit) async {
      emit(_Loading());
      final result = await AuthRemoteDatasource().update(event.model);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_Loaded(data)),
      );
    });

    // Change Password
    on<_ChangePassword>((event, emit) async {
      emit(_Loading());
      final result = await AuthRemoteDatasource()
          .changePassword(event.password, event.newPassword);
      result.fold(
        (error) => emit(_Error(error)),
        (data) => emit(_LoadedMess(data)),
      );
    });
  }
}
