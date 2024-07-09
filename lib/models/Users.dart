import 'package:freezed_annotation/freezed_annotation.dart';


part 'Users.freezed.dart';
part 'Users.g.dart';

@freezed
class Users with _$Users {
  const factory Users({
    required String name,
    required String email,
    required String uid,
    required String? pic,
    required List<String> favouriteList
  }) = _Users;

  factory Users.fromJson(Map<String,dynamic> json) => _$UsersFromJson(json);
}