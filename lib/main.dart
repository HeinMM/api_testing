import 'package:api_testing/data/api_service/post_api_service.dart';
import 'package:api_testing/data/shared_preference/save_data.dart';
import 'package:api_testing/util/locale.dart';
import 'package:api_testing/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  Get.put(PostApiService());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((SharedPreferences sharedPreferences) {
      SaveData.setThemeData(sharedPreferences.getBool('darkTheme') ?? false);
      SaveData.setLanguage(sharedPreferences.getBool('language') ?? false);
      if (SaveData.getThemeData() == true) {
        Get.changeTheme(ThemeData.dark());
      }
      if (SaveData.getThemeData() == false) {
        Get.changeTheme(ThemeData.light());
      }
      if (SaveData.getLanguage() == true) {
        setState(() {
          Get.updateLocale(const Locale('en', 'KR'));
        });
      }
      if (SaveData.getLanguage() == false) {
        setState(() {
          Get.updateLocale(const Locale('en', 'US'));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: RestApiLanguage(), // your translations
      locale: const Locale(
          'en', 'US'), // translations will be displayed in that locale
      fallbackLocale: const Locale('en',
          'US'), // specify the fallback locale in case an invalid locale is selected.
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const BottomNav(),
    );
  }
}
