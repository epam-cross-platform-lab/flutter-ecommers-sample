import 'package:ecommers/core/models/edit_profile_model.dart';
import 'package:ecommers/core/provider_models/profile_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/dimens/insets.dart';
import 'package:ecommers/ui/widgets/back_button.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/profile/profile_image.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatelessWidget {
  static const EdgeInsets _listContainerMargin =
      EdgeInsets.symmetric(horizontal: Insets.x5);

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProviderModel>(context, listen: false);

    nameTextController.text = profileProvider.getName();
    phoneTextController.text = profileProvider.getPhone();

    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        centerTitle: true,
        leading: const BackButton(),
        title: Text(
          localization.editProfile,
          style: textTheme.bodyText1,
        ),
        actions: [
          FlatButton(
            onPressed: () => _saveChanges(profileProvider),
            child: Baseline(
              baselineType: TextBaseline.alphabetic,
              baseline: Insets.x2_5,
              child: Text(
                localization.save,
                style:
                    textTheme.bodyText1.copyWith(color: BrandingColors.primary),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: _listContainerMargin,
          child: Column(
            children: <Widget>[
              _buildProfileImage(),
              const SizedBox(height: Insets.x2),
              Text(
                profileProvider.getEmailOrPhone(),
                style: textTheme.bodyText2,
              ),
              const SizedBox(height: Insets.x3),
              _buildTextFormField(nameTextController, localization.username)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        const ProfileImage(Insets.x25),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            alignment: Alignment.center,
            height: Insets.x8,
            width: Insets.x8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: BrandingColors.backgroundIcon,
              border: Border.all(
                width: Insets.x1,
                color: BrandingColors.pageBackground,
              ),
            ),
            child: SvgPicture.asset(
              Assets.suggestIcon,
              height: Insets.x3_5,
              color: BrandingColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextFormField(
      TextEditingController controller, String labelText) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textTheme.headline5,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: BrandingColors.backgroundIcon),
        ),
        fillColor: Colors.transparent,
        filled: true,
      ),
    );
  }

  void _saveChanges(ProfileProviderModel profileProvider) {
    final model = EditProfileModel(nameTextController.text);
    profileProvider.updateProfileInfo(model);
    navigationService.goBack();
  }
}