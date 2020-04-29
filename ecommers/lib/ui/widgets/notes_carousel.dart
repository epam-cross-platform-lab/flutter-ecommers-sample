import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/shared/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
            (e) => GestureDetector(
              onTap: () => onButtonPressed(e),
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Insets.x2),
                  child: ImageCard(
                    buttonText: e.commandText,
                    description: e.shortDescription,
                    imageUrl: e.imageUrl,
                    onButtonPressed: () => onButtonPressed(e),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Future onButtonPressed(Note noteModel) {
    //TODO:make navigation in provider, navigation should be only in Providers
    return navigationService.navigateTo(Pages.note, arguments: noteModel);
  }
}
