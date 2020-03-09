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
  TextAlign textAlignment = TextAlign.center;
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
      if (focusNode.hasFocus) {
        hintText = '';
        textAlignment = TextAlign.left;
      } else {
        hintText = 'Search something';
        textAlignment = TextAlign.center;
      }
      });
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
              decoration: BoxDecoration(
                  color: BrandingColors.blur,
                  borderRadius: const BorderRadius.all(Radius.circular(20))),
              child: TextFormField (
                focusNode: focusNode,
                textAlign: textAlignment,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(fontSize: 14),
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
