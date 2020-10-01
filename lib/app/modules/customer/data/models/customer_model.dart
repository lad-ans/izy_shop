import 'package:meta/meta.dart';

import '../../../auth/domain/entities/logged_user.dart';
import '../../../auth/domain/entities/logged_user_info.dart';

class CustomerModel extends LoggedUser implements LoggedUserInfo {
  final String uuid;
  CustomerModel({
    @required String name,
    String email,
    String phoneNumber,
    String avatar,
    this.uuid,
  }) : super(
            name: name,
            email: email,
            phoneNumber: phoneNumber,
            avatar: avatar,
          );

  LoggedUser toLoggedUser() => this;
}
