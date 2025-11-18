import 'package:appthemes_v3/models/dashboard_widget.dart';

// checks if the dashboard content is equal to the preset
bool dashboardEquals(
  List<DashboardWidget> current,
  List<DashboardWidget> preset,
) {
  if (current.length != preset.length) return false;
  for (var i = 0; i < current.length; i++) {
    if (current[i].itemId != preset[i].itemId ||
        current[i].size != preset[i].size) {
      return false;
    }
  }
  return true;
}
