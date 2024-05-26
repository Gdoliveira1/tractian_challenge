import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/core/repositories/api_repository.dart";
import "package:tractian_challenge/src/core/service/api_service.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/company/company_page.dart";
import "package:tractian_challenge/src/modules/asset/main/asset_page.dart";

const String routeCompany = "/app/company";
const String routeAsset = "/app/asset";

class AppModule extends Module {
  final String _company = "/company";
  final String _asset = "/asset";

  @override
  void binds(i) {
    i.addSingleton(() => ApiRepository());
    i.addSingleton(() => ApiService(i.get<ApiRepository>()));
    i.addSingleton(() => AssetCubit(i.get<ApiService>()));
  }

  @override
  void routes(r) {
    r.child(_company, child: (_) => const CompanyPage());
    r.child(_asset, child: (_) => AssetPage(companyId: r.args.data));
  }
}
