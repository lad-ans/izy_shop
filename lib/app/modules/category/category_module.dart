import 'category_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'category_page.dart';

class CategoryModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $CategoryController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => CategoryPage()),
      ];

  static Inject get to => Inject<CategoryModule>.of();
}
