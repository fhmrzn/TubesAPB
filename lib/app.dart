

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:device_preview/device_preview.dart';
import 'package:pangyangjourney/utils/theme/theme.dart';

import 'features/authentication/screens/onboarding/onboarding.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      themeMode: ThemeMode.system,
      theme:TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: const OnBoardingScreen(),
    );
  }
}
