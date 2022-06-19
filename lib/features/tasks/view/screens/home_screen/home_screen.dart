import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/features/tasks/view/screens/home_screen/widgets/calender_viewr_widget.dart';
import 'package:to_do_app/features/tasks/view/screens/home_screen/widgets/home_header_widget.dart';
import 'package:to_do_app/features/tasks/view/screens/home_screen/widgets/tasks_list_widget.dart';

import '../../../controller/providers/theme_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: const [
          HomeHeaderWidget(),
          CalenderViewrWidget(),
          TasksListWidget(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  appBar(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    return AppBar(
      elevation: 10,
      leading: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return IconButton(
            onPressed: () {
              provider.changeTheme();
            },
            icon: Icon(theme.isDark
                ? Icons.wb_sunny_outlined
                : Icons.nightlight_round),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.person),
        ),
      ],
    );
  }
}
