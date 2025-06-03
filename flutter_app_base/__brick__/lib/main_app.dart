import 'package:flutter/material.dart';
import 'package:{{app_name}}/core/localization/app_localization_config.dart';
import 'package:{{app_name}}/core/navigation/routes/app_router.dart';
import 'package:{{app_name}}/core/theme/app_theme.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          routerConfig: appRouter,
          darkTheme: AppTheme.dark,
          theme: AppTheme.light,
          themeMode: ThemeMode.system,
          localizationsDelegates: AppLocalizationsConfig.localizationsDelegates,
          supportedLocales: AppLocalizationsConfig.supportedLocales,
          localeResolutionCallback: AppLocalizationsConfig.localeResolution,
        );
      },
    );
  }
}
