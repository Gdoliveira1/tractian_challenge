import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart"
    hide ModularWatchExtension;
import "package:tractian_challenge/src/app_module.dart";
import "package:tractian_challenge/src/domain/constants/app_colors.dart";

class AssetView extends StatefulWidget {
  const AssetView({super.key});

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteSmoke,
        appBar: AppBar(
          backgroundColor: AppColors.whiteSmoke,
          surfaceTintColor: Colors.transparent,
          title: const Text("Assets"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Modular.to.navigate(routeHome);
            },
          ),
        ),
        body: Container());
  }
}
