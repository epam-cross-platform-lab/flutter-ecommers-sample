import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropDownColors extends StatefulWidget {
  final List<String> colors;

  const DropDownColors(this.colors) : super();

  @override
  State<StatefulWidget> createState() => DropDownColorsState(colors);
}

class DropDownColorsState extends State<DropDownColors> {
  final List<String> colors;
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedSubTitle;


  DropDownColorsState(this.colors);

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(colors);
    _selectedSubTitle = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildDropdownMenuItems(
      List<String> subTitleItem) {
    final List<DropdownMenuItem<String>> items = List();
    for (final String subTitleItem in subTitleItem) {
      
      items.add(
        DropdownMenuItem(
          value: subTitleItem,
          child: SizedBox(
            child: Text(subTitleItem, textAlign: TextAlign.left),
          ),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownItem(String selectedSubTitle) {
    setState(() {
      _selectedSubTitle = selectedSubTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: _selectedSubTitle,
      items: _dropdownMenuItems,
      onChanged: onChangeDropdownItem,
      style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Colors.transparent.withOpacity(0.3),
          ),
      underline: const Text(''),
      iconSize: 0,
    );
  }
}
