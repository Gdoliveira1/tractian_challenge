import "package:equatable/equatable.dart";

import "package:tractian_challenge/src/domain/models/company_model.dart";

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

/// State when there is an error loading assets or locations.
class AssetError extends AssetState {
  final String message;

  AssetError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => "AssetError { message: $message }";
}
