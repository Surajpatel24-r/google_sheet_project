import 'package:flutter/material.dart';
import 'package:google_sheet_project/api/sheets/engineering_sheets_api.dart';
import 'package:google_sheet_project/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EngineeringSheetApi.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen());
  }
}
