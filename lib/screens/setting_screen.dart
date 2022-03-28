import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: Column(
        children: [
          Text("Themes"),
          ElevatedButton(onPressed: () {}, child: Text("ADd")),
          Consumer<ThemeProvider>(
            builder: (context, provider, child) {
              return SwitchListTile(
                  title: Text("Dark Mode"),
                  value: provider.isDark,
                  onChanged: (val) => provider.changeTheme());
            },
          ),
        ],
      ),
    );
  }
}
