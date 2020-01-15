import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientCategoryLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/clothes.svg';
    return Container(
      height: 65,
      width: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Color(0xffFF6262).withOpacity(0.34),
               blurRadius: 15.0,
                
               offset: Offset(0, 8))
        ],
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xffFFAE4E), Color(0xffFF7676)]),
      ),
      child: Padding(
          padding: EdgeInsets.all(14),
          child: SvgPicture.asset(
            assetName, 
          )),
    );
  }
}
