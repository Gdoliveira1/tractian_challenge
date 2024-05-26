import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/app_module.dart";
import "package:tractian_challenge/src/app_wrap_page.dart";
import "package:tractian_challenge/src/modules/app_status/app_status_module.dart";

/// A module responsible for defining the main navigation routes and providing singleton instances of core services.
///
/// This module utilizes the Modular package for managing application navigation and dependency injection.
/// Modular provides a convenient way to organize and navigate between modules while also facilitating the

class MainModule extends Module {
  final String _status = "/status";

  final String _initial = "/app";

  @override
  void routes(r) {
    r.child(
      "/",
      child: (_) => const AppWrapPage(),
      transition: TransitionType.noTransition,
      children: [
        ModuleRoute(_status, module: AppStatusModule()),
        ModuleRoute(_initial, module: AppModule()),
      ],
    );
  }
}
