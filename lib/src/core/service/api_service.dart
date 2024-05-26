import "package:tractian_challenge/src/core/repositories/api_repository.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";

class ApiService {
  final ApiRepository apiService;

  ApiService(this.apiService);

  Future<List<CompanyModel>> getCompanies() => apiService.getCompanies();
}
