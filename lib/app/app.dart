import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modules/home/home_module.dart';
import 'modules/home/presenter/pages/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...homeModule
      ],
      child: MaterialApp(
        title: 'Marvel Heroes',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.light,
        darkTheme: ThemeData.dark(),
        theme: ThemeData(
          fontFamily: 'gilroy',
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            toolbarTextStyle: TextStyle(
              color: Colors.red
            )
          )
        ),
        home: const HomePage(),
        //home: const HomePage(),
      ),
    );
  }
}
