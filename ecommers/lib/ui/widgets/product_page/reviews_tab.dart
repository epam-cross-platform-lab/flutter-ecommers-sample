import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommers/ui/widgets/index.dart';

class ReviewsTab extends StatelessWidget {
  final List<ProductReviewsModel> productReviewsModel;

  const ReviewsTab({@required this.productReviewsModel});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) => const SizedBox(height: Insets.x7_5),
      itemCount: productReviewsModel.length,
      itemBuilder: (context, i) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                color: Color(productReviewsModel[i].profileImageColor),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  productReviewsModel[i].nameAbbreviation,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: FontSizes.big_4x,
                    fontWeight: FontWeight.bold,
                    color: Color(productReviewsModel[i].profileImageTextColor),
                  ),
                ),
              ),
            ),
            const SizedBox(width: Insets.x5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar(
                        initialRating: productReviewsModel[i].countOfStars,
                        minRating: 0,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: Insets.x5,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: BrandingColors.primary,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        Formatter.getTextWithSpecifiedDateFormat(
                          productReviewsModel[i].date,
                          'dd MMM, yyyy',
                        ),
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                  const SizedBox(height: Insets.x1_5),
                  Text(
                    productReviewsModel[i].name,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: Insets.x1_5),
                  Text(
                    productReviewsModel[i].description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: Insets.x1_5),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: Insets.x3_5),
                      itemCount:
                          productReviewsModel[i].screenshotsPathes.length,
                      itemBuilder: (context, index) {
                        return CachedImage(
                            imagePath: productReviewsModel[i]
                                .screenshotsPathes[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
