import 'package:flutter/material.dart';
import 'package:gps_tracking/config/enviroment/enviroment.dart';
import 'package:gps_tracking/config/router/app_router.dart';
import 'package:gps_tracking/config/theme/app_theme.dart';
import 'package:gps_tracking/services/web_socket_service.dart';
import 'package:provider/provider.dart';

void main() async{
  await Environment.initEnvironment();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => WebSocketService(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        routerConfig: appRouter,
        theme: AppTheme().getTheme(), // <-- Light theme value
        // darkTheme: AppThemeGlobal.darkTheme, // <-- Dark theme value
        themeMode: ThemeMode.system, // <--- To set Theme Mode as system
      ),
    );
  }
}