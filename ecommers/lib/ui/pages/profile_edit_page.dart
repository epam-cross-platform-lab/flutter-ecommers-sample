import 'package:ecommers/core/models/edit_profile_model.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/insets.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/busy_page.dart';
import 'package:ecommers/ui/widgets/button/primary_button_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/profile/profile_image.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatelessWidget {
  static const EdgeInsets _listContainerMargin =
      EdgeInsets.symmetric(horizontal: Insets.x5);

  final TextEditingController nameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProviderModel>(context, listen: false);
    final passwordProvider =
        Provider.of<ResetPasswordProviderModel>(context, listen: false);

    nameTextController.text = profileProvider.getName();

    return BusyPage<ResetPasswordProviderModel>(
      child: Scaffold(
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
                  style: textTheme.bodyText1
                      .copyWith(color: BrandingColors.primary),
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
                _buildTextFormField(nameTextController, localization.username),
                const SizedBox(height: Insets.x5),
                PrimaryButtonWidget(
                  text: localization.reset_password,
                  assetIconPath: Assets.arrowRightIcon,
                  onPressedFunction: () => _resetPassword(
                      passwordProvider, profileProvider.getEmail()),
                ),
              ],
            ),
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

  void _resetPassword(ResetPasswordProviderModel provider, String email) {
    provider.resetPassword(email);
  }
}
