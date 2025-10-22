import 'dart:ui';
import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:flutter/material.dart';
import '../config/theme/custom_background.dart';
import 'dashboard_background.dart';

enum TitleSize { sm, md, lg, xl }

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final CustomBackground background;

  // AppBar related
  final String? title;
  final Widget? leading;
  final String? subTitle;
  final TitleSize titleSize;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool useAppBar;
  final bool extendBodyBehindAppBar;
  final bool blurBehindAppBar;

  // Bottom related
  final bool bottom;
  final double minBottomPadding;
  final Widget? floatingNavigationBar;
  final Widget? bottomNavigationBar;

  // Other
  final bool resizeToAvoidBottomInset;

  const CustomScaffold({
    Key? key,
    required this.body,
    required this.background,
    this.title,
    this.leading,
    this.subTitle,
    this.titleSize = TitleSize.lg,
    this.actions,
    this.centerTitle = false,
    this.bottom = true,
    this.minBottomPadding = 15,
    this.useAppBar = true,
    this.extendBodyBehindAppBar = false,
    this.floatingNavigationBar,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = true,
    this.blurBehindAppBar = true,
  }) : super(key: key);

  double _getTitleFontSize() {
    switch (titleSize) {
      case TitleSize.sm:
        return 18;
      case TitleSize.md:
        return 22;
      case TitleSize.lg:
        return 26;
      case TitleSize.xl:
        return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.dark900,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: useAppBar && (title != null || leading != null || actions != null)
          ? AppBar(
              title: title != null
                  ? Column(
                      crossAxisAlignment: centerTitle
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title!,
                          style: TextStyle(fontSize: _getTitleFontSize()),
                        ),
                        if (subTitle != null)
                          Text(subTitle!, style: const TextStyle(fontSize: 12)),
                      ],
                    )
                  : null,
              leading: leading,
              actions: actions,
              centerTitle: centerTitle,
              backgroundColor: blurBehindAppBar
                  ? Colors.transparent
                  : Theme.of(context).appBarTheme.backgroundColor,
              elevation: blurBehindAppBar ? 0 : null,
              flexibleSpace: blurBehindAppBar
                  ? ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(color: Colors.black.withOpacity(0.1)),
                      ),
                    )
                  : null,
            )
          : null,
      body: Stack(
        children: [
          DashboardBackground(background: background),
          Padding(
            padding: EdgeInsets.only(bottom: bottom ? minBottomPadding : 0),
            child: body,
          ),
        ],
      ),
      bottomNavigationBar: floatingNavigationBar ?? bottomNavigationBar,
    );
  }
}
