import 'dart:ui';
import 'package:appthemes_v3/widgets/bottom_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_corner/smooth_corner.dart';
import '../config/theme/custom_colors.dart';
import '../config/theme/custom_background.dart';
import '../widgets/custom_safe_area.dart';
import '../widgets/button.dart';
import '../config/theme/custom_painter.dart';
import '../config/theme/size_setter.dart';

class WidgetPickerModal extends StatefulWidget {
  const WidgetPickerModal({super.key});

  @override
  State<WidgetPickerModal> createState() => _WidgetPickerModalState();
}

class _WidgetPickerModalState extends State<WidgetPickerModal> {
  late int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
        
      ],
    );
  }
}
