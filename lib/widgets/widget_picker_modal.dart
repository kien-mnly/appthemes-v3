import 'package:flutter/material.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_theme.dart';
import '../config/theme/asset_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './bottom_modal.dart';
import './widget_preview_modal.dart';
import 'package:appthemes_v3/models/widget_type.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';

class WidgetPickerModal extends StatefulWidget {
  const WidgetPickerModal({super.key, this.items, this.onPick});

  final List<PickerItem>? items;
  final ValueChanged<PickerItem>? onPick;

  @override
  State<WidgetPickerModal> createState() => _WidgetPickerModalState();
}

class _WidgetPickerModalState extends State<WidgetPickerModal> {
  late int currentIndex;
  late List<PickerItem> _items;

  @override
  void initState() {
    super.initState();
    _items =
        widget.items ?? PickerType.values.map((t) => t.toPickerItem()).toList();
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
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = _items[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // open a preview modal on top of the picker
                        BottomDialog.showCustom(
                          context: context,
                          child: WidgetPreviewModal(
                            item: item,
                            onAdd: () {
                              // close preview
                              Navigator.pop(context);
                              // close picker
                              Navigator.pop(context);
                              // notify caller if they want the picked item
                              if (widget.onPick != null) widget.onPick!(item);
                            },
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        item.svgAsset,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(item.nameKey),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  height: 1,
                  color: CustomColors.light.withValues(alpha: 0.12),
                  width: double.infinity,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
