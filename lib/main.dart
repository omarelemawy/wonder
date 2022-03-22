import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';
import 'package:wander_guide/shared/netWork/remot/dio_helper.dart';
import 'modules/login/splash_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context,locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(locale){
    setState(() {
      _locale=locale;
    });
  }
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.orange[800],
        ),
        primarySwatch: Colors.orange,
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
            selectedIconTheme: IconThemeData(color: Colors.orange[800]),
            selectedItemColor:Colors.orange[800] ,
            unselectedItemColor: HexColor("#0f1442"),
            unselectedLabelStyle: TextStyle(color: HexColor("#0f1442")),
            showUnselectedLabels: true
        ),
      ),
      localizationsDelegates: const[
        AppLocale.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      locale: _locale,
      supportedLocales: const[
        Locale("en","US"),
        Locale("ar","EG"),
      ],
      localeResolutionCallback:
          (currentLang,supportLang){
        if(currentLang != null ){
          for (Locale locale in supportLang){
            if(locale.languageCode==currentLang.languageCode){
              return currentLang;
            }
          }
        }
        return supportLang.first;
      },
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: FirstScreen(),
      ),
    );
  }
}
