import "package:flutter_bloc/flutter_bloc.dart";
import "package:tractian_challenge/src/core/service/api_service.dart";
import "package:tractian_challenge/src/domain/models/asset_model.dart";
import "package:tractian_challenge/src/domain/models/asset_tree_node_model.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";
import "package:tractian_challenge/src/domain/models/location_model.dart";
import "package:tractian_challenge/src/modules/asset/bloc/asset_state.dart";

class AssetCubit extends Cubit<AssetState> {
  final ApiService _apiService;

  List<AssetModel> _assets = [];
  List<LocationModel> _locations = [];

  bool showEnergySensorsOnly = false;
  bool showVibrationSensorsOnly = false;
  bool showCriticalSensorsOnly = false;
  String _searchQuery = "";

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

  Future<void> loadData(String companyId) async {
    try {
      emit(AssetLoading());
      _assets = await _apiService.getAssets(companyId);
      _locations = await _apiService.getLocations(companyId);
      _applyFilters();
    } catch (e) {
      emit(AssetError("Failed to load assets or locations"));
    }
  }

  /// endregion

  /// region Filter Methods

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void toggleEnergySensorsFilter() {
    showEnergySensorsOnly = !showEnergySensorsOnly;
    _applyFilters();
  }

  void toggleVibrationSensorsFilter() {
    showVibrationSensorsOnly = !showVibrationSensorsOnly;
    _applyFilters();
  }

  void toggleCriticalSensorsFilter() {
    showCriticalSensorsOnly = !showCriticalSensorsOnly;
    _applyFilters();
  }

  void resetFilters() {
    showEnergySensorsOnly = false;
    showVibrationSensorsOnly = false;
    showCriticalSensorsOnly = false;
    _searchQuery = "";
  }

  void _applyFilters() {
    final tree = _buildTree(_assets, _locations);
    final filteredTree = _filterTree(
      tree,
      _searchQuery,
      showEnergySensorsOnly,
      showVibrationSensorsOnly,
      showCriticalSensorsOnly,
    );
    emit(AssetTreeLoaded(filteredTree));
  }

  /// endregion

  /// region Tree Building Methods

  List<AssetTreeNodeModel> _buildTree(
    List<AssetModel> assets,
    List<LocationModel> locations,
  ) {
    final Map<String, List<AssetTreeNodeModel>> locationToAssets = {};
    final Map<String, List<AssetTreeNodeModel>> assetToChildren = {};
    final Map<String, List<AssetTreeNodeModel>> locationToLocations = {};
    final Map<String, AssetTreeNodeModel> idToNode = {};

    for (final asset in assets) {
      final node = AssetTreeNodeModel(
        id: asset.id,
        name: asset.name,
        sensorType: asset.sensorType,
        status: asset.status,
        children: [],
      );
      idToNode[asset.id] = node;

      if (asset.locationId != null) {
        locationToAssets.putIfAbsent(asset.locationId!, () => []).add(node);
      } else if (asset.parentId != null) {
        assetToChildren.putIfAbsent(asset.parentId!, () => []).add(node);
      } else {
        locationToAssets.putIfAbsent("unlinked", () => []).add(node);
      }
    }

    for (final location in locations) {
      final node = AssetTreeNodeModel(
        id: location.id,
        name: location.name,
        children: locationToAssets[location.id] ?? [],
      );
      idToNode[location.id] = node;

      if (location.parentId != null) {
        locationToLocations.putIfAbsent(location.parentId!, () => []).add(node);
      }
    }

    for (final parent in locationToLocations.keys) {
      if (idToNode.containsKey(parent)) {
        idToNode[parent]!.children.addAll(locationToLocations[parent]!);
      }
    }

    for (final parent in assetToChildren.keys) {
      if (idToNode.containsKey(parent)) {
        idToNode[parent]!.children.addAll(assetToChildren[parent]!);
      }
    }

    final List<AssetTreeNodeModel> rootNodes = locations
        .where((location) => location.parentId == null)
        .map((location) => idToNode[location.id]!)
        .toList();

    if (locationToAssets.containsKey("unlinked")) {
      rootNodes.addAll(locationToAssets["unlinked"]!);
    }

    return rootNodes;
  }

  /// endregion

  /// region Tree Filtering Methods

  List<AssetTreeNodeModel> _filterTree(
    List<AssetTreeNodeModel> nodes,
    String query,
    bool showEnergySensorsOnly,
    bool showVibrationSensorsOnly,
    bool showCriticalSensorsOnly,
  ) {
    final List<AssetTreeNodeModel> filteredNodes = [];

    for (final node in nodes) {
      final bool matchesQuery =
          node.name.toLowerCase().contains(query.toLowerCase());
      final bool matchesEnergySensor =
          !showEnergySensorsOnly || node.sensorType == "energy";
      final bool matchesVibrationSensor =
          !showVibrationSensorsOnly || node.sensorType == "vibration";
      final bool matchesCriticalStatus =
          !showCriticalSensorsOnly || node.status == "alert";

      if (matchesQuery &&
          matchesEnergySensor &&
          matchesVibrationSensor &&
          matchesCriticalStatus) {
        filteredNodes.add(node);
      } else {
        final filteredChildren = _filterTree(
          node.children,
          query,
          showEnergySensorsOnly,
          showVibrationSensorsOnly,
          showCriticalSensorsOnly,
        );
        if (filteredChildren.isNotEmpty) {
          filteredNodes.add(AssetTreeNodeModel(
            id: node.id,
            name: node.name,
            sensorType: node.sensorType,
            status: node.status,
            children: filteredChildren,
          ));
        }
      }
    }

    return filteredNodes;
  }

  /// endregion
}
