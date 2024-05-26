import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart"
    hide ModularWatchExtension;
import "package:flutter_svg/flutter_svg.dart";
import "package:tractian_challenge/src/app_module.dart";
import "package:tractian_challenge/src/domain/constants/app_text_styles.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_state.dart";
import "package:tractian_challenge/src/shared/custom_message_info.dart";

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    unawaited(context.read<AssetCubit>().loadCompanies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Companies",
          style: AppTextStyles.black24w700,
        ),
      ),
      body: BlocBuilder<AssetCubit, AssetState>(
        builder: (context, state) {
          if (state is AssetLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompaniesLoaded) {
            return ListView.builder(
              itemCount: state.companies.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/icon.svg",
                          ),
                          const SizedBox(width: 20),
                          Text(
                            state.companies[index].name,
                            style: AppTextStyles.white16w400sfprodisplay,
                          ),
                          const Expanded(child: SizedBox.shrink())
                        ],
                      )),
                  onTap: () {
                    Modular.to.navigate(routeAssets,
                        arguments: state.companies[index].id);
                  },
                );
              },
            );
          } else if (state is AssetError) {
            return CustomMessageInfo(message: state.message);
          } else {
            return const CustomMessageInfo(message: "No companies found");
          }
        },
      ),
    );
  }
}
