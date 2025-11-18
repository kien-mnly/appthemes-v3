import 'package:appthemes_v3/config/theme/custom_colors.dart';
import 'package:appthemes_v3/widgets/widget_config.dart' hide WidgetContent;
import 'package:flutter/material.dart';
import 'package:appthemes_v3/models/enums/widget_size.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import '../config/theme/custom_theme.dart';

class WidgetContainer extends StatefulWidget {
  final WidgetContent item;
  final Widget? previewChild;
  final int initialIndex;
  final ValueChanged<int>? onPageChanged;

  final bool preview;
  final WidgetSize? fixedSize;
  final bool isEditMode;
  final VoidCallback? onDelete;

  const WidgetContainer({
    super.key,
    required this.item,
    this.previewChild,
    this.initialIndex = 0,
    this.onPageChanged,
    this.preview = true,
    this.fixedSize,
    this.isEditMode = false,
    this.onDelete,
  });
  @override
  State<WidgetContainer> createState() => _WidgetContainerState();
}

class _WidgetContainerState extends State<WidgetContainer> {
  late final PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = 300.0;
    final sizes = widget.item.supportedSizes;

    return Column(
      children: [
        SizedBox(
          height: maxHeight,
          child: PageView.builder(
            itemCount: sizes.length,
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
              widget.onPageChanged?.call(index);
            },
            itemBuilder: (context, index) {
              final size = sizes[index];
              final content = WidgetConfig(
                item: widget.item,
                size: widget.fixedSize ?? size,
                isEditMode: widget.isEditMode,
                onDelete: widget.onDelete,
              );

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  content,
                  const SizedBox(height: 8),
                  Text(
                    size.name,
                    style: CustomTheme(context).themeData.textTheme.bodyMedium,
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(sizes.length, (index) {
            final isActive = index == currentIndex;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive ? CustomColors.green300 : CustomColors.light600,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }
}
