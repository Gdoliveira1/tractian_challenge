import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/core/repositories/api_repository.dart";
import "package:tractian_challenge/src/core/service/api_service.dart";
import "package:tractian_challenge/src/modules/asset/asset_page.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/home/home_page.dart";

const String routeHome = "/app/home";
const String routeAssets = "/app/assets";

class AppModule extends Module {
  final String _home = "/home";
  final String _assets = "/assets";

  @override
  void binds(i) {
    i.addSingleton(() => ApiRepository());
    i.addSingleton(() => ApiService(i.get<ApiRepository>()));
    i.addSingleton(() => AssetCubit(i.get<ApiService>()));
  }

  @override
  void routes(r) {
    r.child(_home, child: (_) => const HomePage());
    r.child(_assets, child: (_) => AssetPage(companyId: r.args.data));
  }
}
