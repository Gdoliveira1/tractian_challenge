import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart"
    hide ModularWatchExtension;
import "package:tractian_challenge/src/app_module.dart";
import "package:tractian_challenge/src/domain/constants/app_colors.dart";
import "package:tractian_challenge/src/modules/asset/asset_tree/asset_tree_view.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_state.dart";
import "package:tractian_challenge/src/shared/custom_message_info.dart";

class AssetView extends StatefulWidget {
  const AssetView({super.key});

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  @override
  void initState() {
    super.initState();
    context.read<AssetCubit>().resetFilters();
  }

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
              Modular.to.navigate(routeCompany);
            },
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  context.read<AssetCubit>().updateSearchQuery(value);
                },
                decoration: const InputDecoration(
                  hintText: "Buscar Ativo ou Local",
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: [
                  FilterChip(
                    avatar: const Icon(Icons.bolt, color: Colors.yellow),
                    label: const Text("Sensor de Energia"),
                    selected: context.watch<AssetCubit>().showEnergySensorsOnly,
                    onSelected: (selected) {
                      context.read<AssetCubit>().toggleEnergySensorsFilter();
                    },
                  ),
                  FilterChip(
                    avatar: const Icon(Icons.warning, color: Colors.red),
                    label: const Text("Crítico"),
                    selected:
                        context.watch<AssetCubit>().showCriticalSensorsOnly,
                    onSelected: (selected) {
                      context.read<AssetCubit>().toggleCriticalSensorsFilter();
                    },
                  ),
                  FilterChip(
                    avatar: const Icon(Icons.vibration, color: Colors.blue),
                    label: const Text("Sensor de Vibração"),
                    selected:
                        context.watch<AssetCubit>().showVibrationSensorsOnly,
                    onSelected: (selected) {
                      context.read<AssetCubit>().toggleVibrationSensorsFilter();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<AssetCubit, AssetState>(
                builder: (context, state) {
                  if (state is AssetLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AssetTreeLoaded) {
                    return AssetTreeView(nodes: state.assetTree);
                  } else if (state is AssetError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const CustomMessageInfo(
                      message: "No assets found",
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
