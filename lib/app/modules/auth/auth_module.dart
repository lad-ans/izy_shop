import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'auth_controller.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/sign_in.dart';
import 'domain/usecases/sign_in_with_facebook.dart';
import 'domain/usecases/sign_in_with_google.dart';
import 'domain/usecases/sign_up.dart';
import 'presentation/pages/action_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/signup_page.dart';
import 'presentation/stores/sign_in_store.dart';
import 'presentation/stores/sign_in_with_facebook_store.dart';
import 'presentation/stores/sign_in_with_google_store.dart';
import 'presentation/stores/sign_up_store.dart';

class AuthModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $AuthController,
        Bind((i) => FirebaseFirestore.instance),
        $AuthRepositoryImpl,
        $SignInImpl,
        $SignUpImpl,
        $SignUpStore,
        $SignInStore,
        $SignInWithGoogleStore,
        $SignInWithGoogleImpl,
        $SignInWithFacebookStore,
        $SignInWithFacebookImpl,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ActionPage()),
        ModularRouter('/login', child: (_, args) => LoginPage()),
        ModularRouter('/signup', child: (_, args) => SignUpPage()),
      ];

  static Inject get to => Inject<AuthModule>.of();
}
