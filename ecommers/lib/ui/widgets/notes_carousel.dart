import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/models/data_models/index.dart';
import '../../generated/i18n.dart';
import '../../ui/decorations/dimens/index.dart';
import '../../ui/widgets/index.dart';

class NotesCarousel extends StatelessWidget {
  final List<Note> notes;

  const NotesCarousel({Key key, this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (notes == null || notes.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.x6),
          child: Text(
            I18n.of(context).latetstTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: Insets.x2_5),
        _buildCarousel(context),
      ],
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return CarouselSlider(
      viewportFraction: 0.92,
      items: notes
          .map(
            (e) => SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.x2),
                child: ImageCard(
                  buttonText: e.commandText,
                  description: e.title,
                  imageUrl: e.imageUrl,
                  onButtonPressed: () {}, //TODO: handle Click
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
