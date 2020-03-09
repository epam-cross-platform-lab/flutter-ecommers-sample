import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchTextFiled extends StatefulWidget {
  @override
  _SerchState createState() => _SerchState();
}

class _SerchState extends State<SearchTextFiled> {
  FocusNode focusNode = FocusNode();
  String hintText = 'Search something';
  Alignment alignment = Alignment.center;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
        alignment = Alignment.centerLeft;
      } else {
        hintText = 'Search something';
        alignment = Alignment.center;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 40,
              alignment: alignment,
              decoration: BoxDecoration(
                  color: BrandingColors.blur,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: TextFormField (
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(fontSize: 12),
                  contentPadding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 0, top: 5),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                ),
                onEditingComplete: () => {},  ///TODO:pass value to provider
              ),
            ),
          ),
        ],
      ),
    );
  }
}
