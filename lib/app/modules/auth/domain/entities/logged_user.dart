import 'package:equatable/equatable.dart';

class LoggedUser extends Equatable {
  final String email;
  final String name;
  final String phoneNumber;
  final String avatar;

  const LoggedUser({
    this.email,
    this.name,
    this.phoneNumber,
    this.avatar,
  });

  @override
  List<Object> get props => [email, name, phoneNumber];
}
