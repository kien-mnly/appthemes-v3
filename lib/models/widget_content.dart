import '../models/enums/widget_type.dart';
import '../models/enums/widget_size.dart';

class WidgetContent {
  final String id;
  final String svgAsset;
  final WidgetType type;
  final Map<String, dynamic>? meta;

  final List<WidgetSize> supportedSizes;

  const WidgetContent({
    required this.id,
    required this.svgAsset,
    required this.type,
    this.meta,
    this.supportedSizes = WidgetSize.values,
  });
}
