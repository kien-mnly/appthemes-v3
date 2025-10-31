import 'package:flutter/material.dart';

class WidgetCard {
  final String id;
  final String titleKey;
  final String? subtitle;
  final WidgetBuilder cardBuilder;
  final Map<String, dynamic>? meta;

  const WidgetCard({
    required this.id,
    required this.titleKey,
    this.subtitle,
    required this.cardBuilder,
    this.meta,
  });
}
