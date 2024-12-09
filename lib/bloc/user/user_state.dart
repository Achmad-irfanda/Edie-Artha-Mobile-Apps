part of 'user_bloc.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.loading() = _Loading;
  const factory UserState.loaded(UserResponseModel data) = _Loaded;
  const factory UserState.loadedMess(String message) = _LoadedMess;
  const factory UserState.error(String message) = _Error;
}
