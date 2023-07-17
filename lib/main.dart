import 'package:country_app/screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:country_app/screens/detailspage.dart';
import 'package:country_app/screens/homepage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/provider/theme_provider.dart';
import 'models/theme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isdarktheme = prefs.getBool('isdark') ?? false;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            thmeModel: ThmeModel(isdark: isdarktheme),
          ),
        ),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode:
              (Provider.of<ThemeProvider>(context).thmeModel.isdark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          routes: {
            '/': (context) => SplashScreen(),
            'homepage': (context) => HomePage(),
            'DetailsPage': (context) => const DetailsPage(),
          },
        );
      },
    ),
  );
}
