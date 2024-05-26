import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";
import "package:tractian_challenge/src/app_module.dart";
import "package:tractian_challenge/src/modules/app_status/bloc/app_status_state.dart";

class AppStatusCubit extends Cubit<AppStatusState> {
  AppStatusCubit() : super(const AppStatusState()) {
    init();
  }

  void init() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Modular.to.navigate(routeCompany);
    });
  }
}
