import 'package:api_testing/data/shared_preference/save_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late bool _darkTheme;
  late bool _krLanguage;
  @override
  void initState() {
    super.initState();
    _darkTheme = SaveData.getThemeData();
    _krLanguage = SaveData.getLanguage();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    _darkTheme = (brightness == Brightness.dark);
    return Scaffold(
      appBar: AppBar(
        title:  Text("setting".tr),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              leading: const Text('Dark Theme'),
              trailing: Switch(
                  value: _darkTheme,
                  onChanged: (value) {
                    if (value) {
                      setState(() {
                        Get.changeTheme(ThemeData.dark());
                        SaveData.setThemeData(true);
                        SaveData.save('darkTheme', true);
                      });
                    } else {
                      setState(() {
                        Get.changeTheme(ThemeData.light());
                        SaveData.setThemeData(false);
                        SaveData.save('darkTheme', false);
                      });
                    }
                  }),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Text('한국어'),
              trailing: Switch(
                  value: _krLanguage,
                  onChanged: (val) {
                    if (val) {
                      setState(() {
                        Get.updateLocale(const Locale('en', 'KR'));
                        SaveData.setLanguage(true);
                        SaveData.save('language', true);
                        _krLanguage = !_krLanguage;
                      });
                    } else {
                      setState(() {
                        Get.updateLocale(const Locale('en', 'US'));
                        SaveData.setLanguage(false);
                        SaveData.save('language', false);
                        _krLanguage = !_krLanguage;
                      });
                    }
                  }),
            ),
          )
        ],
      ),
    );
  }
}
