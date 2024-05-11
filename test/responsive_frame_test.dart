import 'animated_show_hide_test.dart' as animated_show_hide_test;
import 'breakpoints_granular_test.dart' as breakpoints_granular_test;
import 'breakpoints_handler_granular_test.dart'
    as breakpoints_handler_granular_test;
import 'breakpoints_handler_test.dart' as breakpoints_handler_test;
import 'breakpoints_test.dart' as breakpoints_test;
import 'dimensions_config_test.dart' as dimensions_config_test;
import 'frame_config_test.dart' as frame_config_test;
import 'frame_horizontal_end_test.dart' as frame_horizontal_end_test;
import 'frame_vertical_end_test.dart' as frame_vertical_end_test;
import 'responsive_widget_granular_test.dart'
    as responsive_widget_granular_test;
import 'responsive_widget_test.dart' as responsive_widget_test;

void main() {
  animated_show_hide_test.main();
  responsive_widget_test.main();
  responsive_widget_granular_test.main();
  breakpoints_handler_test.main();
  breakpoints_handler_granular_test.main();
  breakpoints_test.main();
  breakpoints_granular_test.main();
  dimensions_config_test.main();
  frame_config_test.main();
  frame_horizontal_end_test.main();
  frame_vertical_end_test.main();
}
