import "package:flutter/material.dart";
import "package:tractian_challenge/src/domain/models/asset_tree_node_model.dart";
import "package:tractian_challenge/src/modules/asset/widgets/custom_location_node.dart";

class AssetTreeView extends StatelessWidget {
  final List<AssetTreeNodeModel> nodes;

  const AssetTreeView({
    required this.nodes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        return buildNode(nodes[index], 0.0);
      },
    );
  }

  Widget buildNode(AssetTreeNodeModel node, double marginLeft) {
    return CustomNode(
      node: node,
      childNodes: [
        for (final child in node.children) buildNode(child, marginLeft + 8.0),
      ],
      marginLeft: marginLeft,
      nodeIndent: 8.0,
    );
  }
}
