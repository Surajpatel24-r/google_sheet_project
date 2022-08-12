import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sheet_project/api/sheets/engineering_sheets_api.dart';
import 'package:google_sheet_project/main.dart';
import 'package:google_sheet_project/model/user.dart';
import 'package:google_sheet_project/widget/button_widget.dart';
import 'package:google_sheet_project/widget/user_form_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sheets Api"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
        child: UserFormWidget(
          onSavedUser: (user) async {
            await EngineeringSheetApi.insert(
              [user.toJson()],
            );
          },
        ),
      ),
    );
  }

  Future insertUsers() async {
    final users = [
      User(
          id: 1,
          name: 'Suraj Patel',
          email: 'surajkpatel24@gmail.com',
          isBeginner: true),
      User(
          id: 2,
          name: 'Ravi Roy',
          email: 'raviroy24@gmail.com',
          isBeginner: true),
    ];

    final jsonUsers = users.map((user) => user.toJson()).toList();

    await EngineeringSheetApi.insert(jsonUsers);
  }
}
