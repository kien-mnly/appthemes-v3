import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../config/theme/custom_background.dart';
import './custom_safe_area.dart';
import 'dashboard_background.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_theme.dart';
import '../config/theme/size_setter.dart';

enum TitleSize { sm, md, lg, xl }

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final CustomBackground background;

  final String? title;
  final Widget? leading;
  final String? subTitle;
  final TitleSize titleSize;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool useAppBar;
  final bool extendBodyBehindAppBar;
  final bool blurBehindAppBar;

  final bool bottom;
  final double minBottomPadding;
  final Widget? floatingNavigationBar;
  final Widget? bottomNavigationBar;

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
    this.resizeToAvoidBottomInset = false,
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
    return DashboardBackground(
      background: background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        extendBody: true,
        appBar: !useAppBar
            ? null
            : AppBar(
                iconTheme: IconThemeData(color: CustomColors.light100),
                backgroundColor: Colors.transparent,
                centerTitle: centerTitle,
                elevation: 0,
                scrolledUnderElevation: 0,
                clipBehavior: Clip.none,
                leadingWidth: 55,
                systemOverlayStyle: SystemUiOverlayStyle.light,
                leading: leading,
                toolbarHeight: 70,
                titleSpacing: SizeSetter.getHorizontalScreenPadding(),
                flexibleSpace: blurBehindAppBar
                    ? ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.05),
                          ),
                        ),
                      )
                    : null,
                title: title != null
                    ? Text(
                        title!,
                        style: TextStyle(
                          fontSize: _getTitleFontSize(),
                          fontWeight: FontWeight.bold,
                          color: CustomColors.light100,
                        ),
                      )
                    : null,
                bottom: subTitle != null
                    ? PreferredSize(
                        preferredSize: Size.fromHeight(
                          10 * MediaQuery.textScalerOf(context).scale(2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            bottom: 10,
                            top: 10,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              subTitle!,
                              style: CustomTheme(context)
                                  .themeData
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: CustomColors.dark600),
                            ),
                          ),
                        ),
                      )
                    : null,
                actions: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: SizeSetter.getHorizontalScreenPadding(),
                    ),
                    child: Row(children: actions ?? []),
                  ),
                ],
              ),
        body: CustomSafeArea(
          top: !useAppBar,
          bottom: bottom,
          minBottomPadding: minBottomPadding,
          child: body,
        ),
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingNavigationBar,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
