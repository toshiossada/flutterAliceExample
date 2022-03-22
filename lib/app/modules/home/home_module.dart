import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/pages/home_controller.dart';
import 'presenter/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HomeController(http: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
