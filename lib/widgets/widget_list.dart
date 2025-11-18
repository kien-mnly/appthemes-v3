import 'package:flutter/material.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './bottom_modal.dart';
import 'widget_modal.dart';
import 'package:appthemes_v3/models/widget_content.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';

class WidgetList extends StatefulWidget {
  const WidgetList({super.key, this.items, this.onPick});

  final List<WidgetContent>? items;
  final ValueChanged<WidgetContent>? onPick;

  @override
  State<WidgetList> createState() => _WidgetListState();
}

class _WidgetListState extends State<WidgetList> {
  late int currentIndex;
  late List<WidgetContent> _items;

  @override
  void initState() {
    super.initState();
    _items =
        widget.items ?? WidgetType.values.map((t) => t.widgetItem).toList();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.6;

    return DefaultTextStyle.merge(
      style: CustomTheme(context).themeData.textTheme.bodyLarge?.copyWith(
        color: CustomColors.light,
        fontWeight: FontWeight.w600,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: ListView.separated(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = _items[index];
            return GestureDetector(
              onTap: () {
                if (widget.onPick != null) {
                  widget.onPick!(item);
                } else {
                  BottomDialog.showCustom(
                    context: context,
                    child: WidgetModal(
                      item: item,
                      onAdd: (item, selectedIndex) {},
                    ),
                  );
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset(
                        item.svgAsset,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Text(item.id),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    height: 1,
                    color: CustomColors.light.withValues(alpha: 0.12),
                    width: double.infinity,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
