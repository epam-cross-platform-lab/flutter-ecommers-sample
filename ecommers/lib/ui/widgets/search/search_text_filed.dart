import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchTextFiled extends StatelessWidget {
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
              child: TextFormField(
                //focusNode: focusNode,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: I18n.of(context).searchProductHintTilt,
                  contentPadding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 0, top: 7),
                  //prefixText: hintText,
                  prefixIcon: Padding(
                    padding: const EdgeInsetsDirectional.only(start: 100, end:5),
                    child: Icon(
                      Icons.search,
                      size: 15,
                    ),
                  ),
                ),
                onEditingComplete: () => {},

                //TODO pass value to provider
              ),
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // _SerchState createState() => _SerchState();
}

// class _SerchState extends State<SearchTextFiled> {
//   FocusNode focusNode = FocusNode();
//   Text hintText = Text(I18n.of(context).searchProductHintTilt);
//   TextAlign textAlignment = TextAlign.left;

//   _SerchState();
//   @override
//   void initState() {
//     super.initState();
//     focusNode.addListener(() {
//       setState(() {
//         if (focusNode.hasFocus) {
//           hintText = const Text('');
//           textAlignment = TextAlign.left;
//         } else {
//           hintText = 'Search something';
//           textAlignment = TextAlign.left;
//         }
//       });
//     });
//   }
