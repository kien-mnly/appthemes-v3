import '../models/widget_card.dart';
import '../models/enums/widget_type.dart';
import '../models/enums/widget_size.dart';

class WidgetItem {
  final String id;
  final String svgAsset;
  final WidgetType type;
  final List<WidgetCard> cards;
  final Map<String, dynamic>? meta;

  final List<WidgetSize> supportedSizes;

  const WidgetItem({
    required this.id,
    required this.svgAsset,
    required this.type,
    required this.cards,
    this.meta,
    this.supportedSizes = WidgetSize.values,
  });
}
