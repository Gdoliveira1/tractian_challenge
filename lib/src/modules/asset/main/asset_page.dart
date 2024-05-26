import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/main/asset_view.dart";

class AssetPage extends StatefulWidget {
  final String companyId;

  const AssetPage({required this.companyId, super.key});

  @override
  State<AssetPage> createState() => _AssetPageState();
}

class _AssetPageState extends State<AssetPage> {
  final AssetCubit _assetCubit = Modular.get<AssetCubit>();

  @override
  void initState() {
    unawaited(_assetCubit.loadData(widget.companyId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _assetCubit,
      child: const AssetView(),
    );
  }
}
