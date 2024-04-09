import 'package:flutter/material.dart';
import 'package:tdd_2_flutter/core/res/colors.dart';
import 'package:tdd_2_flutter/core/res/fonts.dart';
import 'package:tdd_2_flutter/core/services/injection_container.dart';
import 'package:tdd_2_flutter/core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Education App',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: Fonts.different,
        colorScheme:
            ColorScheme.fromSwatch(accentColor: CustomColors.primaryColor),
        appBarTheme: const AppBarTheme(
          color: Colors.transparent,
        ),
      ),
      onGenerateRoute: generateRoute,
    );
  }
}
