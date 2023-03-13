import 'package:barbers/utils/colorer.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {
  final void Function(String)? onChanged;
  const SearchWidget({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 10,
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search_rounded),
          hintText: "Arama",
        ),
        onChanged: widget.onChanged,
        style: TextStyle(color: Colorer.onBackground),
      ),
    );
  }
}
