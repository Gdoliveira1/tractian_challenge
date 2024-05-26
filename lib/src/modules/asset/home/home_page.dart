import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/home/home_view.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AssetCubit _assetCubit = Modular.get<AssetCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _assetCubit,
      child: const HomeView(),
    );
  }
}
