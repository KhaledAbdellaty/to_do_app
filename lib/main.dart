import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/core/theme.dart';
import 'package:to_do_app/features/tasks/view/screens/home_screen/home_screen.dart';

import 'features/awesome_notification/notification_init.dart';
import 'features/tasks/controller/providers/date_provider.dart';
import 'features/tasks/controller/providers/task_provider.dart';
import 'features/tasks/controller/providers/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyNotifications.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskProvider>(
          create: (context) => TaskProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider<DateProvider>(
          create: (context) => DateProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (context, provider, child) {
        return const MaterialAppWithTheme();
      }),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  const MaterialAppWithTheme({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: theme.isDark ? Themes.dark : Themes.light,
      home: const HomeScreen(),
    );
  }
}
