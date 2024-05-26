import "package:tractian_challenge/src/core/repositories/api_repository.dart";
import "package:tractian_challenge/src/domain/models/asset_model.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";
import "package:tractian_challenge/src/domain/models/location_model.dart";

class ApiService {
  final ApiRepository apiService;

  ApiService(this.apiService);

  Future<List<CompanyModel>> getCompanies() => apiService.getCompanies();
  Future<List<LocationModel>> getLocations(String companyId) =>
      apiService.getLocations(companyId);
  Future<List<AssetModel>> getAssets(String companyId) =>
      apiService.getAssets(companyId);
}
