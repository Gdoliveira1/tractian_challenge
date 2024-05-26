import "package:flutter_bloc/flutter_bloc.dart";
import "package:tractian_challenge/src/core/service/api_service.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";

import "package:tractian_challenge/src/modules/asset/bloc/asset_state.dart";

class AssetCubit extends Cubit<AssetState> {
  final ApiService _apiService;

  AssetCubit(this._apiService) : super(AssetInitial());

  /// region Load Data Methods

  Future<void> loadCompanies() async {
    try {
      emit(AssetLoading());
      final List<CompanyModel> companies = await _apiService.getCompanies();
      emit(CompaniesLoaded(companies));
    } catch (e) {
      emit(AssetError("Failed to load companies"));
    }
  }

  /// endregion
}
