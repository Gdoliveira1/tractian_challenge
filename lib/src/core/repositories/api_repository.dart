import "package:dio/dio.dart";
import "package:tractian_challenge/src/core/controllers/notification_controller.dart";
import "package:tractian_challenge/src/domain/enums/response_status_enum.dart";
import "package:tractian_challenge/src/domain/models/asset_model.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";
import "package:tractian_challenge/src/domain/models/location_model.dart";
import "package:tractian_challenge/src/domain/models/response_status_model.dart";

class ApiRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fake-api.tractian.com"));

  Future<List<CompanyModel>> getCompanies() {
    return _dio.get("/companies").then((response) {
      return (response.data as List)
          .map((json) => CompanyModel.fromJson(json))
          .toList();
    }).catchError((error) {
      _displayResponseAlert(ResponseStatusModel(
          error: error,
          status: ResponseStatusEnum.failed,
          message: "Falha ao Buscar Dados das Companias"));
      throw error;
    });
  }

  Future<List<LocationModel>> getLocations(String companyId) {
    final uri = "/companies/$companyId/locations";

    return _dio.get(uri).then((response) {
      final List<LocationModel> locations = (response.data as List)
          .map((json) => LocationModel.fromJson(json))
          .toList();

      return locations;
    }).catchError((error) {
      _displayResponseAlert(ResponseStatusModel(
          error: error,
          status: ResponseStatusEnum.failed,
          message: "Falha ao Buscar Dados das Locações"));
      throw error;
    });
  }

  Future<List<AssetModel>> getAssets(String companyId) {
    final uri = "/companies/$companyId/assets";

    return _dio.get(uri).then((response) {
      final List<AssetModel> assets = (response.data as List)
          .map((json) => AssetModel.fromJson(json))
          .toList();
      return assets;
    }).catchError((error) {
      _displayResponseAlert(ResponseStatusModel(
          error: error,
          status: ResponseStatusEnum.failed,
          message: "Falha ao Buscar Dados das Assets"));
      throw error;
    });
  }

  void _displayResponseAlert(ResponseStatusModel response) async {
    NotificationController.snackBar(response: response);
  }
}
