part of 'user_bloc.dart';

@freezed
class UserEvent with _$UserEvent {
  const factory UserEvent.started() = _Started;
  const factory UserEvent.user() = _User;
  const factory UserEvent.update(UserRequestModel model) = _Update;
  const factory UserEvent.changePassword(String password, newPassword) =
      _ChangePassword;
}
