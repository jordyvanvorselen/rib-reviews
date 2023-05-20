import 'package:integration_test/integration_test.dart';

import 'login_screen_feature.dart' as login_screen;
import 'home_screen_feature.dart' as home_screen;
import 'review_screen_feature.dart' as review_screen;
import 'review_modal_feature.dart' as review_modal;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  login_screen.main();
  home_screen.main();
  review_screen.main();
  review_modal.main();
}
