import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../controller/providers/theme_provider.dart';
import '../../new_task_screen/new_task_screen.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTextHeaderWidget(context),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewTaskScreen()));
            },
            child: const Text('Add New Task'),
          ),
        ],
      ),
    );
  }
  Widget _buildTextHeaderWidget(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          DateFormat.yMMMMd().format(DateTime.now()),
          style: TextStyle(
            color: themeProvider.isDark ? Colors.grey[200] : Colors.grey[800],
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "Today",
          style: TextStyle(
            color: themeProvider.isDark ? Colors.grey[200] : Colors.grey[800],
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}