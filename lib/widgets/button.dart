import 'dart:ui';

import '../config/theme/custom_colors.dart';
import '../config/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:smooth_corner/smooth_corner.dart';

enum ButtonType { primary, secondary, outline, danger }

enum ButtonSize { sm, md }

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.title,
    required this.onPressed,
    this.disabled = false,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.size = ButtonSize.md,
    this.withOutline = false,
  });

  final String title;
  final Function()? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool disabled;
  final ButtonSize size;
  final bool withOutline;

  Color getBackgroundColor(type) {
    switch (type) {
      case ButtonType.primary:
        return CustomColors.green300;
      case ButtonType.secondary:
        return CustomColors.black.withValues(alpha: 0.25);
      case ButtonType.outline:
        return Colors.transparent;
      case ButtonType.danger:
        return CustomColors.error;
      default:
        return CustomColors.secondary;
    }
  }

  Color getTextColor(type) {
    switch (type) {
      case ButtonType.primary:
        return CustomColors.dark;
      case ButtonType.secondary:
        return CustomColors.light100;
      case ButtonType.outline:
        return CustomColors.light100;
      default:
        return CustomColors.light;
    }
  }

  Widget _makeButton(BuildContext context) {
    final borderRadius = BorderRadius.circular(100);

    Widget buttonContent = Container(
      width: size == ButtonSize.md ? double.infinity : null,
      decoration: BoxDecoration(borderRadius: borderRadius),
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: (type == ButtonType.secondary)
            ? ClipRRect(
                borderRadius: borderRadius,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Material(
                    color: getBackgroundColor(type),
                    surfaceTintColor: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    shape: SmoothRectangleBorder(
                      borderRadius: borderRadius,
                      smoothness: 0.65,
                      side: BorderSide.none,
                    ),
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: disabled || isLoading ? null : onPressed,
                      child: isLoading
                          ? const Center(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    CustomColors.dark,
                                  ),
                                ),
                              ),
                            )
                          : Text(
                              title,
                              style: CustomTheme(context)
                                  .themeData
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: getTextColor(type),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                    ),
                  ),
                ),
              )
            : Material(
                color: getBackgroundColor(type),
                surfaceTintColor: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                shape: SmoothRectangleBorder(
                  borderRadius: borderRadius,
                  smoothness: 0.65,
                  side: type == ButtonType.outline
                      ? const BorderSide(color: CustomColors.light500, width: 1)
                      : BorderSide.none,
                ),
                child: MaterialButton(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: disabled || isLoading ? null : onPressed,
                  child: isLoading
                      ? const Center(
                          child: SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                CustomColors.dark,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          title,
                          style: CustomTheme(context)
                              .themeData
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: getTextColor(type),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                ),
              ),
      ),
    );
    return buttonContent;
  }

  @override
  Widget build(BuildContext context) {
    return withOutline
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: CustomColors.light500, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: _makeButton(context),
            ),
          )
        : _makeButton(context);
  }
}
