import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> assetImagePaths;
  final double height;
  final double imageScale;
  static final _currentPageNotifier = ValueNotifier<int>(0);

  const CarouselWidget({
    @required this.assetImagePaths,
    @required this.height,
    this.imageScale,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            _buildCircleIndicator(),
            _buildPageView(),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleIndicator() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: Insets.x5, bottom: Insets.x5),
        child: CirclePageIndicator(
          itemCount: assetImagePaths.length,
          selectedDotColor: BrandingColors.secondary,
          dotColor: BrandingColors.backgroundIcon,
          currentPageNotifier: _currentPageNotifier,
        ),
      ),
    );
  }

  Widget _buildPageView() {
    return Container(
      height: height,
      child: PageView.builder(
          itemCount: assetImagePaths.length,
          controller: PageController(),
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Image.asset(
                assetImagePaths[index],
                scale: imageScale,
              ),
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }
}
