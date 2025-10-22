import 'custom_colors.dart';
import 'size_setter.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  BuildContext context;

  // Font Family
  static const fontFamily = 'Poppins';

  CustomTheme(this.context);

  ThemeData get themeData {
    SizeSetter.construct(context);

    return ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
        // Display
        displayLarge: TextStyle(
          fontSize: SizeSetter.getDisplayLargeSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w700,
          height: 1,
          color: CustomColors.light,
        ),
        displayMedium: TextStyle(
          fontSize: SizeSetter.getDisplayMediumSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),
        displaySmall: TextStyle(
          fontSize: SizeSetter.getDisplaySmallSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),

        // Headline -- 700
        headlineLarge: TextStyle(
          fontSize: SizeSetter.getHeadlineLargeSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),
        headlineMedium: TextStyle(
          fontSize: SizeSetter.getHeadlineMediumSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),
        headlineSmall: TextStyle(
          fontSize: SizeSetter.getHeadlineSmallSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),

        // Title -- 500
        titleLarge: TextStyle(
          fontSize: SizeSetter.getTitleLargeSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),
        titleMedium: TextStyle(
          fontSize: SizeSetter.getTitleMediumSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),
        titleSmall: TextStyle(
          fontSize: SizeSetter.getTitleSmallSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          height: 1,
          color: CustomColors.light,
        ),

        // Label -- 900
        labelSmall: TextStyle(
          fontSize: SizeSetter.getLabelSmallSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          height: 1,
          color: CustomColors.light,
        ),
        labelMedium: TextStyle(
          fontSize: SizeSetter.getLabelMediumSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w500,
          height: 1,
          color: CustomColors.light,
        ),
        labelLarge: TextStyle(
          fontSize: SizeSetter.getLabelLargeSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w600,
          height: 1,
          color: CustomColors.light,
        ),

        // Body -- 400
        bodyLarge: TextStyle(
          fontSize: SizeSetter.getBodyLargeSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w400,
          color: CustomColors.light,
        ),
        bodyMedium: TextStyle(
          fontSize: SizeSetter.getBodyMediumSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w300,
          color: CustomColors.light,
        ),
        bodySmall: TextStyle(
          fontSize: SizeSetter.getBodySmallSize(),
          fontFamily: fontFamily,
          fontWeight: FontWeight.w300,
          color: CustomColors.light,
        ),
      ),
    );
  }
}
