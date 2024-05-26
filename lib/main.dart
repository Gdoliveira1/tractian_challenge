import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/main_module.dart";
import "package:tractian_challenge/src/modules/app_status/app_status_module.dart";

void main() {
  runApp(ModularApp(module: MainModule(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(routeAppLoading);
    return MaterialApp.router(
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: "Tractian Challenge",
      debugShowCheckedModeBanner: false,
    );
  }
}
