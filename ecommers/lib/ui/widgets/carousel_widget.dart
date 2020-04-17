import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

class CarouselWidget extends StatelessWidget {
  final List<CarouselImage> images;
  final ValueNotifier<int> currentPageNotifier;
  final PageController currentPageController;
  final double height;

  const CarouselWidget({
    @required this.images,
    @required this.currentPageNotifier,
    @required this.currentPageController,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final _localization = I18n.of(context);

    if (images?.isNotEmpty == true) {
      return _buildBody();
    }

    return Center(
      child: Text(
        _localization.noAvailableInformation,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: <Widget>[
        _buildCircleIndicator(),
        const SizedBox(height: Insets.x2_5),
        _buildPageView(),
      ],
    );
  }

  Widget _buildCircleIndicator() {
    return CirclePageIndicator(
      itemCount: images.length,
      selectedDotColor: BrandingColors.secondary,
      dotColor: BrandingColors.backgroundIcon,
      currentPageNotifier: currentPageNotifier,
    );
  }

  Widget _buildPageView() {
    return SizedBox(
      height: height,
      child: PageView.builder(
          itemCount: images.length,
          controller: currentPageController,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: HeroImage(
                tag: images[index].tag,
                imagePath: images[index].path,
              ),
            );
          },
          onPageChanged: (int index) {
            currentPageNotifier.value = index;
          }),
    );
  }
}
