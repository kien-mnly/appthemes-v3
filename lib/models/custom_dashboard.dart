import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';

class CustomDashboard {
  final String name;
  final List<DashboardWidget> content;
  final BackgroundTheme theme;

  CustomDashboard({
    required this.name,
    required this.content,
    required this.theme,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'content': content.map((element) => element.toJson()).toList(),
      'theme': theme.index,
    };
  }

  factory CustomDashboard.fromJson(Map<String, dynamic> json) {
    final list = (json['content'] as List)
        .cast<Map<String, dynamic>>()
        .map(DashboardWidget.fromJson)
        .toList();

    final themeIndex = json['theme'];

    return CustomDashboard(
      name: json['name'] as String,
      content: list,
      theme: BackgroundTheme.values[themeIndex],
    );
  }
}
