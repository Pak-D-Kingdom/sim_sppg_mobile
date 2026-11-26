import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'core/localization/app_localizations_extension.dart';
import 'core/localization/locale_cubit.dart';
import 'core/routes/app_router.dart';
import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(AppTheme.systemUiOverlayStyle);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl.isRegistered<LocaleCubit>()
          ? di.sl<LocaleCubit>()
          : LocaleCubit(),
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, currentLocale) {
          return MaterialApp(
            title: 'SIM SPPG Mobile',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            locale: currentLocale,
            localizationsDelegates:
                AppLocalizationsConfig.localizationsDelegates,
            supportedLocales: AppLocalizationsConfig.supportedLocales,
            initialRoute: AppRoutes.login,
            onGenerateRoute: AppRouter.onGenerateRoute,
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: AppTheme.systemUiOverlayStyle,
                child: child ?? const SizedBox.shrink(),
              );
            },
          );
        },
      ),
    );
  }
}
