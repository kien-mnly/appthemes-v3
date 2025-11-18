import './enums/widget_size.dart';

class DashboardWidget {
  final String itemId;
  final WidgetSize size;

  const DashboardWidget({required this.itemId, required this.size});
  DashboardWidget copyWith({String? itemId, WidgetSize? size}) {
    return DashboardWidget(
      itemId: itemId ?? this.itemId,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toJson() => {'itemId': itemId, 'size': size.name};
  factory DashboardWidget.fromJson(Map<String, dynamic> json) {
    return DashboardWidget(
      itemId: json['itemId'],
      size: WidgetSize.values.firstWhere(
        (widgetSize) => widgetSize.name == json['size'],
        orElse: () => WidgetSize.regular,
      ),
    );
  }
}
