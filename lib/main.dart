import 'package:flutter/material.dart';
import 'package:gallery_app/contoer/images_controler.dart';
import 'package:gallery_app/view/pages/homepages.dart';
import 'package:provider/provider.dart';

import 'contoer/theme_controler.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ImagesControler(),),
        ChangeNotifierProvider(create: (context) => ThemeControler(),),

      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.light
          ),
          darkTheme: ThemeData(useMaterial3: true,brightness: Brightness.dark),
          themeMode: (Provider.of<ThemeControler>(context,listen: true).t.isDark)?ThemeMode.dark:ThemeMode.light,
          home: HomePage(),
        );
      },
    );
  }
}
