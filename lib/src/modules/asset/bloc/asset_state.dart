import "package:equatable/equatable.dart";
import "package:tractian_challenge/src/domain/models/asset_model.dart";
import "package:tractian_challenge/src/domain/models/asset_tree_node_model.dart";
import "package:tractian_challenge/src/domain/models/company_model.dart";
import "package:tractian_challenge/src/domain/models/location_model.dart";

/// Base class for all asset states.
abstract class AssetState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Initial state of the asset cubit.
class AssetInitial extends AssetState {}

/// State when assets and locations are being loaded.
class AssetLoading extends AssetState {}

/// State when companies are loaded successfully.
class CompaniesLoaded extends AssetState {
  final List<CompanyModel> companies;

  CompaniesLoaded(this.companies);

  @override
  List<Object?> get props => [companies];

  @override
  String toString() => "CompaniesLoaded { companies: $companies }";
}

/// State when assets and locations are loaded successfully.
class AssetsAndLocationsLoaded extends AssetState {
  final List<AssetModel> assets;
  final List<LocationModel> locations;

  AssetsAndLocationsLoaded(this.assets, this.locations);

  @override
  List<Object?> get props => [assets, locations];

  @override
  String toString() =>
      "AssetsAndLocationsLoaded { assets: $assets, locations: $locations }";
}

/// State when the asset tree is built and loaded successfully.
class AssetTreeLoaded extends AssetState {
  final List<AssetTreeNodeModel> assetTree;

  AssetTreeLoaded(this.assetTree);

  @override
  List<Object?> get props => [assetTree];

  @override
  String toString() => "AssetTreeLoaded { assetTree: $assetTree }";
}

/// State when there is an error loading assets or locations.
class AssetError extends AssetState {
  final String message;

  AssetError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => "AssetError { message: $message }";
}
