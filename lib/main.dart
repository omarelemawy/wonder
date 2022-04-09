import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hex_color/flutter_hex_color.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:wander_guide/componants/app_locale.dart';
import 'package:wander_guide/shared/netWork/local/cache_helper.dart';
import 'package:wander_guide/shared/netWork/remot/dio_helper.dart';
import 'modules/login/splash_screen.dart';

void main() async{
  DioHelper.init();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await CacheHelper.init();
  bool result = await InternetConnectionChecker().hasConnection;
  if(result == true) {
    print('YAY! Free cute dog pics!');
  } else {
    print('No internet :( Reason:');
  }
  runApp( MyApp(result: result,));
}

class MyApp extends StatefulWidget {
  bool result;
   MyApp({Key key,this.result}) : super(key: key);
  static void setLocale(BuildContext context,locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }
  @override
  State<MyApp> createState() => _MyAppState(result);
}

class _MyAppState extends State<MyApp> {
  bool result;
  _MyAppState(this.result);
  Locale _locale;
  setLocale(locale){
    setState(() {
      _locale=locale;
    });
  }
  @override
  Widget build(BuildContext context) {

    return /* result ?*/ MaterialApp(
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
        /*:MaterialApp(
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
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child:  NoInterNet(),
      ),
    );*/
  }
}
class NoInterNet extends StatelessWidget {
  const NoInterNet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(),
    );
  }
}

