import 'package:integration_test/integration_test.dart';

import 'home_screen_feature.dart' as home_screen;
import 'login_screen_feature.dart' as login_screen;
import 'review_modal_feature.dart' as review_modal;
import 'review_screen_feature.dart' as review_screen;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  binding.testTextInput.register();

  login_screen.main();
  home_screen.main();
  review_screen.main();
  review_modal.main();
}
