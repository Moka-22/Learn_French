import 'package:flutter/material.dart';
import '../../models/sections_model.dart';

class SectionsItemWidget extends StatefulWidget {
  const SectionsItemWidget({
    super.key,
    required this.categoryItem,
    required this.sections,
  });
  final CategoryModel categoryItem;
  final List<Widget> sections;

  @override
  State<SectionsItemWidget> createState() => _SectionsItemWidgetState();
}

class _SectionsItemWidgetState extends State<SectionsItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return widget.sections[0];
                    },
                  ),
                );
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(widget.categoryItem.image),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.categoryItem.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
