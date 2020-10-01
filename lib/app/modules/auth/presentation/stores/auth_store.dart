import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../domain/entities/logged_user_info.dart';
import '../../domain/usecases/usecases/get_logged_user.dart';
import '../../domain/usecases/usecases/logout.dart';

part 'auth_store.g.dart';

@Injectable()
class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final GetLoggedUser getLoggedUser;
  final Logout logout;
  _AuthStoreBase(this.getLoggedUser, this.logout);

  @observable
  LoggedUserInfo user;

  @computed
  bool get isLogged => user != null;

  @action
  void setUser(LoggedUserInfo value) => user = value;

  Future<bool> checkLogin() async {
    var user = await getLoggedUser();
    setUser(user);
    return true;
  }

  Future signOut() async {
    await logout();
    setUser(null);
  }
}
