import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ecommers/ui/widgets/index.dart';

class ReviewsTab extends StatelessWidget {
  static const ratesCount = 5;
  final List<ProductReview> productReviewsModel;

  const ReviewsTab({@required this.productReviewsModel});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final _localization = I18n.of(context);

    if (productReviewsModel?.isNotEmpty == true) {
      return ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) =>
            const SizedBox(height: Insets.x7_5),
        itemCount: productReviewsModel.length,
        itemBuilder: (context, i) {
          final review = productReviewsModel[i];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFCDD2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    Formatter.getAlias(
                        review.user?.firstName, review.user?.lastName),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: FontSizes.big_4x,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFF9C4),
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
                          initialRating: Formatter.getRating(review.rate),
                          minRating: 0,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: ratesCount,
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
                            review.date,
                            'dd MMM, yyyy',
                          ),
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                    const SizedBox(height: Insets.x1_5),
                    Text(
                      Formatter.getUserName(
                          review.user?.firstName, review.user?.lastName),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(height: Insets.x1_5),
                    Text(
                      review.comment ?? '',
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
                        itemCount: review.imageUrls?.length ?? 0,
                        itemBuilder: (context, index) {
                          return review.imageUrls?.isNotEmpty == true
                              ? CachedImage(imagePath: review.imageUrls[index])
                              : null;
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

    return Center(
      child: Text(
        _localization.noAvailableInformation,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
