import './enums/widget_size.dart';

class WidgetConfig {
  final String id;
  final String itemId;
  final WidgetSize size;
  final int selectedIndex;

  const WidgetConfig({
    required this.id,
    required this.itemId,
    required this.size,
    required this.selectedIndex,
  });

  WidgetConfig copyWith({
    String? id,
    String? itemId,
    String? titleKey,
    WidgetSize? size,
    int? selectedIndex,
  }) {
    return WidgetConfig(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      size: size ?? this.size,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'itemId': itemId,
    'size': size.name,
    'selectedIndex': selectedIndex,
  };

  factory WidgetConfig.fromJson(Map<String, dynamic> json) {
    return WidgetConfig(
      id: json['id'],
      itemId: json['itemId'],
      size: WidgetSize.values.firstWhere(
        (widgetSize) => widgetSize.name == json['size'],
        orElse: () => WidgetSize.regular,
      ),
      selectedIndex: json['selectedIndex'],
    );
  }
}
