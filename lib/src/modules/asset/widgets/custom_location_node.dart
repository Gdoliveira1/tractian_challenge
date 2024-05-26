import "package:flutter/material.dart";
import "package:tractian_challenge/src/domain/models/asset_tree_node_model.dart";

class CustomNode extends StatefulWidget {
  final AssetTreeNodeModel node;
  final List<Widget> childNodes;
  final double marginLeft;
  final double nodeIndent;

  const CustomNode({
    required this.node,
    required this.childNodes,
    required this.marginLeft,
    required this.nodeIndent,
    super.key,
  });

  @override
  State<CustomNode> createState() => _CustomNodeState();
}

class _CustomNodeState extends State<CustomNode> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: widget.marginLeft),
          child: ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.node.children.isNotEmpty)
                  IconButton(
                    icon: Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                    ),
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                getNodeIcon(widget.node),
              ],
            ),
            title: Row(
              children: [
                Flexible(child: Text(widget.node.name)),
                if (widget.node.sensorType == "energy")
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.bolt,
                      color: Color(0xFF52C41A),
                      size: 20,
                    ),
                  ),
                if (widget.node.status == "alert")
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: Color(0xFFED3833),
                      size: 12,
                    ),
                  ),
                if (widget.node.sensorType == "vibration")
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.vibration_outlined,
                      color: Color(0xFF52C41A),
                      size: 20,
                    ),
                  ),
              ],
            ),
            onTap: () {
              if (widget.node.children.isNotEmpty) {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
          ),
        ),
        if (_isExpanded)
          Padding(
            padding:
                EdgeInsets.only(left: widget.marginLeft + widget.nodeIndent),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.childNodes,
            ),
          ),
      ],
    );
  }

  Widget getNodeIcon(AssetTreeNodeModel node) {
    if (node.sensorType != null) {
      return Image.asset("assets/icons/component.png", height: 24.0);
    } else if (node.children.isNotEmpty) {
      return Image.asset("assets/icons/asset.png", height: 24.0);
    } else {
      return Image.asset("assets/icons/location.png", height: 24.0);
    }
  }
}
