import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/company/company_view.dart";

class CompanyPage extends StatefulWidget {
  const CompanyPage({super.key});

  @override
  State<CompanyPage> createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  final AssetCubit _assetCubit = Modular.get<AssetCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _assetCubit,
      child: const CompanyView(),
    );
  }
}
