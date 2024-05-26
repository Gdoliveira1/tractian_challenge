class AssetTreeNodeModel {
  final String id;
  final String name;
  final String? sensorType;
  final String? status;
  List<AssetTreeNodeModel> children;

  AssetTreeNodeModel({
    required this.id,
    required this.name,
    this.sensorType,
    this.status,
    List<AssetTreeNodeModel>? children,
  }) : children = children ?? [];
}
