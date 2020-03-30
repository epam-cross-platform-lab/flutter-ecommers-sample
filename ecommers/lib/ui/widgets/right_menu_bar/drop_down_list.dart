import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropDownList extends StatefulWidget {
  final List<String> subTitles;

  const DropDownList(this.subTitles) : super();

  @override
  State<StatefulWidget> createState() => DropDownState(subTitles);
}

class DropDownState extends State<DropDownList> {
  final List<String> subTitles;
  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedSubTitle;

  DropDownState(this.subTitles);

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(subTitles);
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
            child: Text(subTitleItem, textAlign: TextAlign.center),
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
