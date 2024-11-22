import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todoappn/core/helper/sqflit_base.dart';
import 'package:todoappn/view/screen/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteHelper.instance.initDataBase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.r)))),
          title: "first",
          home: child,
        );
      },
      child: home(),
    );
  }
}
