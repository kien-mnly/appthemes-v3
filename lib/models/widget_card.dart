import 'package:flutter/material.dart';

class WidgetCard {
  final String id;
  final String titleKey;
  final WidgetBuilder cardBuilder;

  const WidgetCard({
    required this.id,
    required this.titleKey,
    required this.cardBuilder,
  });
}
