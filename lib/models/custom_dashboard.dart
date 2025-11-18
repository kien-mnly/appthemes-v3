import 'package:appthemes_v3/models/dashboard_widget.dart';
import 'package:appthemes_v3/models/enums/background_theme.dart';

class CustomDashboard {
  final String name;
  final List<DashboardWidget> dashboards;
  final BackgroundTheme theme;

  CustomDashboard({
    required this.name,
    required this.dashboards,
    required this.theme,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dashboards': dashboards.map((element) => element.toJson()).toList(),
      'theme': theme.index,
    };
  }

  factory CustomDashboard.fromJson(Map<String, dynamic> json) {
    final list = (json['dashboards'] as List)
        .cast<Map<String, dynamic>>()
        .map(DashboardWidget.fromJson)
        .toList();

    final themeIndex = json['theme'];

    return CustomDashboard(
      name: json['name'] as String,
      dashboards: list,
      theme: BackgroundTheme.values[themeIndex],
    );
  }
}
