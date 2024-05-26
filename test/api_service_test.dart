import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:tractian_challenge/src/core/service/api_service.dart";
import "package:tractian_challenge/src/domain/models/asset_model.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";
import "package:tractian_challenge/src/domain/models/location_model.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_cubit.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_state.dart";

// Mock of the ApiService class
class MockApiService extends Mock implements ApiService {}

void main() {
  group("AssetCubit", () {
    late AssetCubit assetCubit;
    late MockApiService mockApiService;

    // Initial setup for the tests
    setUp(() {
      mockApiService = MockApiService();
      assetCubit = AssetCubit(mockApiService);
    });

    // Test for the loadCompanies method
    test("loadCompanies", () async {
      // Sample list of companies
      final companies = [CompanyModel(id: "1", name: "Company 1")];

      // Mock the getCompanies method to return the sample companies list
      when(() => mockApiService.getCompanies())
          .thenAnswer((_) async => companies);

      // Call the method to load the companies
      await assetCubit.loadCompanies();

      // Verify that the state emitted after loading the companies is CompaniesLoaded
      expect(
        assetCubit.state,
        isA<CompaniesLoaded>()
            .having((state) => state.companies, "companies", companies),
      );
    });

    // Test for the loadData method
    test("loadData", () async {
      // Sample company ID
      const companyId = "1";

      // Sample lists of assets and locations
      final assets = [AssetModel(id: "1", name: "Asset 1", locationId: "1")];
      final locations = [LocationModel(id: "1", name: "Location 1")];

      // Mock the getAssets and getLocations methods to return the sample lists
      when(() => mockApiService.getAssets(companyId))
          .thenAnswer((_) async => assets);
      when(() => mockApiService.getLocations(companyId))
          .thenAnswer((_) async => locations);

      // Call the method to load the assets and locations
      await assetCubit.loadData(companyId);

      // Verify that the state emitted after loading is AssetTreeLoaded
      expect(
        assetCubit.state,
        isA<AssetTreeLoaded>().having(
          (state) => state.assetTree,
          "assetTree",
          isNotEmpty,
        ),
      );

      // Optionally, you can further verify the structure of the asset tree
      final assetTree = (assetCubit.state as AssetTreeLoaded).assetTree;
      expect(assetTree.length, 1);
      expect(assetTree[0].name, "Location 1");
      expect(assetTree[0].children.length, 1);
      expect(assetTree[0].children[0].name, "Asset 1");
    });
  });
}
