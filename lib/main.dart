import 'package:flutter/material.dart';
import 'package:sunti/my_app.dart';

import '/core/utils/helpers/languages/dependency_inj.dart' as dep;
import 'core/services/services_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await dep.init();
  await ServicesLocator().init();
  runApp(MyApp(languages: languages));
}
