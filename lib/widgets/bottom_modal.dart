import 'dart:ui';

import '../config/theme/custom_colors.dart';
import '../config/theme/asset_icons.dart';
import '../config/theme/size_setter.dart';
import '../config/theme/custom_theme.dart';

import './button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_corner/smooth_corner.dart';

class DialogAction {
  Key? key;
  String title;
  Function()? onPressed;
  ButtonType? type;

  DialogAction({
    this.key,
    required this.title,
    required this.onPressed,
    this.type = ButtonType.primary,
  });
}

class BottomDialog {
  static Future showCustom({
    Key? key,
    required BuildContext context,
    Widget? child,
    bool isDismissible = true,
    bool blurBackground = true,
    bool useGlassEffect = true,
    double blurSigma = 12,
  }) async {
    return showCupertinoModalPopup(
      context: context,
      barrierDismissible: isDismissible,
      filter: blurBackground
          ? ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma)
          : null,
      builder: (BuildContext context) => PopScope(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GestureDetector(
            // Dismiss the modal if the user swipes down on it
            onVerticalDragEnd: isDismissible
                ? (details) => {
                    if (details.primaryVelocity! > 0) {Navigator.pop(context)},
                  }
                : null,
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: SmoothRectangleBorder(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  smoothness: 0.7,
                  side: const BorderSide(width: 1, color: CustomColors.dark700),
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: useGlassEffect ? blurSigma : 0,
                  sigmaY: useGlassEffect ? blurSigma : 0,
                ),
                child: Container(
                  key: key,
                  width: double.infinity,
                  decoration: ShapeDecoration(
                    shape: SmoothRectangleBorder(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      smoothness: 0.7,
                      side: BorderSide(width: 1, color: CustomColors.dark700),
                    ),
                    color: useGlassEffect
                        ? CustomColors.black.withValues(alpha: 0.45)
                        : CustomColors.dark900,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeSetter.getHorizontalScreenPadding(),
                      vertical: 15,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isDismissible
                            ? Container(
                                height: 4,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: CustomColors.dark800,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              )
                            : const SizedBox(),
                        if (child != null) ...[
                          const SizedBox(height: 25),
                          child,
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Future show({
    Key? key,
    required BuildContext context,
    Widget? child,
    List<DialogAction>? actions,
    bool isDismissible = true,
    bool blurBackground = true,
    bool useGlassEffect = true,
    double blurSigma = 12,
  }) async {
    return BottomDialog.showCustom(
      key: key,
      context: context,
      isDismissible: isDismissible,
      blurBackground: blurBackground,
      useGlassEffect: useGlassEffect,
      blurSigma: blurSigma,
      child: Column(
        children: [
          if (child != null) ...[child, const SizedBox(height: 25)],
          if (actions != null) ...[
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => Button(
                key: actions[index].key,
                title: actions[index].title,
                onPressed: actions[index].onPressed,
                type: actions[index].type!,
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: actions.length,
            ),
            const SizedBox(height: 25),
          ],
        ],
      ),
    );
  }

  static Future showError({
    Key? key,
    required BuildContext context,
    required String message,
    String? title,
    String? buttonText,
  }) async {
    return BottomDialog.showCustom(
      key: key,
      context: context,
      child: Column(
        children: [
          SvgPicture.asset(
            AssetIcons.zinVoltLogo,
            width: 48,
            height: 48,
            colorFilter: ColorFilter.mode(CustomColors.error, BlendMode.srcIn),
          ),
          const SizedBox(height: 25),
          Text(
            'general error',
            style: CustomTheme(context).themeData.textTheme.titleLarge,
          ),
          const SizedBox(height: 10),
          Text(
            message,
            style: CustomTheme(context).themeData.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Button(
            title: buttonText ?? 'ok',
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ).then((_) => debugPrint('Error dialog closed'));
  }
}
