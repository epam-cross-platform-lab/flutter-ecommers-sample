import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class CarouselWidget extends StatelessWidget {
  final List<String> assetImagePaths;
  static const _imageScale = 0.5;
  static final _currentPageNotifier = ValueNotifier<int>(0);

  const CarouselWidget({@required this.assetImagePaths});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildCircleIndicator(),
        _buildPageView(),
      ],
    );
  }

  Widget _buildCircleIndicator() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: Insets.x2),
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
    return Expanded(
      child: PageView.builder(
          itemCount: assetImagePaths.length,
          controller: PageController(),
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Image.asset(
                assetImagePaths[index],
                scale: _imageScale,
              ),
            );
          },
          onPageChanged: (int index) {
            _currentPageNotifier.value = index;
          }),
    );
  }
}
