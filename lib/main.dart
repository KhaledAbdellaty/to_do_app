
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/database/database_provider.dart';
import 'package:to_do_app/providers/date_provider.dart';
import 'package:to_do_app/providers/notification_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/model/theme_model.dart';
import 'package:to_do_app/screens/homePage_screen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await NotificationProvider().initializeNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<DateProvider>(
            create: (context)=> DateProvider()),
        ChangeNotifierProvider<NotificationProvider>(
            create: (context)=> NotificationProvider()),
        ChangeNotifierProvider<DatabaseProvider>(
            create: (context)=> DatabaseProvider.instance),


      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return const MaterialAppWithTheme();
        }
      ),
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
      //darkTheme: theme.changeTheme(),
      home: HomePage(),
    );
  }
}
