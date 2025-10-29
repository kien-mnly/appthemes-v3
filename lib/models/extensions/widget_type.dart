import 'package:flutter/material.dart';
import 'package:appthemes_v3/models/enums/widget_type.dart';

class PickerItem {
  final String nameKey;
  final String svgAsset;
  final PickerType type;
  final String? subtitle;
  final WidgetBuilder? previewBuilder;
  final VoidCallback? onAdd;
  final Map<String, dynamic>? meta;

  const PickerItem({
    required this.nameKey,
    required this.svgAsset,
    required this.type,
    this.subtitle,
    this.previewBuilder,
    this.onAdd,
    this.meta,
  });
}
