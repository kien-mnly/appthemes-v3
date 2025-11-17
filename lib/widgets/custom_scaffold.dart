import 'dart:ui';

import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/config/theme/custom_theme.dart';
import 'package:appthemes_v3/config/theme/size_setter.dart';
import 'package:appthemes_v3/services/background_service.dart';
import 'package:appthemes_v3/widgets/custom_safe_area.dart';
import 'package:appthemes_v3/widgets/dashboard_background.dart';
import 'package:appthemes_v3/config/dependency_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watch_it/watch_it.dart';

enum TitleSize { sm, md, lg }

class CustomScaffold extends WatchingWidget {
  const CustomScaffold({
    required this.body,
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
    super.key,
  });

  final Widget? title;
  final Widget body;
  final String? subTitle;
  final Widget? leading;
  final TitleSize titleSize;
  final List<Widget>? actions;
  final bool centerTitle;
  final bool bottom;
  final double minBottomPadding;
  final bool useAppBar;
  final bool extendBodyBehindAppBar;
  final Widget? floatingNavigationBar;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;
  final bool blurBehindAppBar;

  @override
  Widget build(BuildContext context) {
    final currentBackground = watch(
      locator<BackgroundService>(),
    ).currentBackgroundTheme;
    return DashboardBackground(
      background: currentBackground,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: extendBodyBehindAppBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        // extendBody: true,
        appBar: !useAppBar
            ? null
            : AppBar(
                iconTheme: IconThemeData(color: CustomColors.light100),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
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
                title: title,
                bottom: subTitle != null
                    ? PreferredSize(
                        // Scale the height to account for accessibility text sizes
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
