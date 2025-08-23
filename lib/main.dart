import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/service_locator.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const MyApp());
}

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
    return ScreenUtilInit(
      designSize: const Size(390, 844), // مقاسات التصميم (iPhone 12 مثلاً)
      builder: (_, __) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) =>
        AppLocalizations.of(context)?.appTitle ?? 'Product Catalog',
        theme: buildLightTheme(),
        routerConfig: appRouter, // routes بتاعتنا
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        builder: (context, child) {
          return Directionality(
            textDirection: _locale.languageCode == 'ar'
                ? TextDirection.rtl
                : TextDirection.ltr,
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
