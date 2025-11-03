import './enums/widget_size.dart';

class WidgetConfig {
  final String id;
  final String itemId;
  final WidgetSize size;
  final int selectedIndex;
  final Map<String, dynamic>? meta;

  const WidgetConfig({
    required this.id,
    required this.itemId,
    required this.size,
    required this.selectedIndex,
    required this.meta,
  });

  WidgetConfig copyWith({
    String? id,
    String? itemId,
    String? titleKey,
    WidgetSize? size,
    int? selectedIndex,
    Map<String, dynamic>? meta,
  }) {
    return WidgetConfig(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      size: size ?? this.size,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      meta: meta ?? this.meta,
    );
  }
}
