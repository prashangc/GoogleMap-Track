import 'package:blog/config/route/nav.dart';
import 'package:blog/config/route/route_generator.dart';
import 'package:blog/config/route/routes.dart';
import 'package:blog/core/injector/dependency_injection.dart';
import 'package:blog/providers.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await GetItServices.serviceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: MultiBlocProvider(
        providers: AllProviders.providers,
        child: MaterialApp(
          navigatorKey: Nav.navKey,
          builder: (context, child) {
            child = BotToastInit()(context, child);
            return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child,
            );
          },
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.root,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }
}
