import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en');

  void _toggleLocale() {
    setState(() {
      _locale = _locale.languageCode == 'en'
          ? const Locale('ar')
          : const Locale('en');
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isNotFirstLogin = false;
    final String token = "";

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) =>
        AppLocalizations.of(context)?.appTitle ?? 'Product Catalog',
        theme: buildLightTheme(),
        routerConfig: AppRouter.getRouter(
          isNotFirstLogin: isNotFirstLogin,
          token: token,
        ),
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          return Directionality(
            textDirection:
            _locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Stack(
              children: [
                child ?? const SizedBox.shrink(),
                PositionedDirectional(
                  bottom: 16,
                  end: 16,
                  child: FloatingActionButton.extended(
                    onPressed: _toggleLocale,
                    label: Text(_locale.languageCode == 'en' ? 'AR' : 'EN'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
