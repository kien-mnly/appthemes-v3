import './enums/widget_size.dart';

class DashboardConfig {
  final String itemId;
  final WidgetSize size;
  final int selectedIndex;

  const DashboardConfig({
    required this.itemId,
    required this.size,
    required this.selectedIndex,
  });

  DashboardConfig copyWith({
    String? id,
    String? itemId,
    String? titleKey,
    WidgetSize? size,
    int? selectedIndex,
  }) {
    return DashboardConfig(
      itemId: itemId ?? this.itemId,
      size: size ?? this.size,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  Map<String, dynamic> toJson() => {
    'itemId': itemId,
    'size': size.name,
    'selectedIndex': selectedIndex,
  };

  factory DashboardConfig.fromJson(Map<String, dynamic> json) {
    return DashboardConfig(
      itemId: json['itemId'],
      size: WidgetSize.values.firstWhere(
        (widgetSize) => widgetSize.name == json['size'],
        orElse: () => WidgetSize.regular,
      ),
      selectedIndex: json['selectedIndex'],
    );
  }
}
