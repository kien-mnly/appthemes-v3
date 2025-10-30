import './enums/widget_size.dart';

class WidgetConfig {
  final String id;
  final String titleKey;
  final WidgetSize size;
  final Map<String, dynamic>? meta;

  const WidgetConfig({
    required this.id,
    required this.titleKey,
    required this.size,
    this.meta,
  });

  WidgetConfig copyWith({
    String? id,
    String? titleKey,
    WidgetSize? size,
    Map<String, dynamic>? meta,
  }) {
    return WidgetConfig(
      id: id ?? this.id,
      titleKey: titleKey ?? this.titleKey,
      size: size ?? this.size,
      meta: meta ?? this.meta,
    );
  }
}
