import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_sheet_project/model/user.dart';
import 'package:google_sheet_project/widget/button_widget.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;
  const UserFormWidget({Key? key, required this.onSavedUser}) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late bool isBeginner;

  @override
  void initState() {
    super.initState();

    initData();
  }

  void initData() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    this.isBeginner = true;
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildName(),
          const SizedBox(
            height: 16,
          ),
          buildEmail(),
          const SizedBox(
            height: 16,
          ),
          buildFlutterBeginner(),
          const SizedBox(
            height: 16,
          ),
          buildSubmit(),
        ],
      );

  Widget buildName() => TextFormField(
        controller: _nameController,
        decoration:
            InputDecoration(labelText: "Name", border: OutlineInputBorder()),
      );

  Widget buildEmail() => TextFormField(
        controller: _emailController,
        decoration:
            InputDecoration(labelText: "Email", border: OutlineInputBorder()),
      );

  Widget buildFlutterBeginner() => SwitchListTile(
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        value: true,
        onChanged: (value) => setState(() => isBeginner = value),
        title: Text("Is Flutter Beginner?"),
      );

  Widget buildSubmit() => ButtonWidget(
        text: 'Save',
        onClicked: () {
          final user = User(
            name: _nameController.text,
            email: _emailController.text,
            isBeginner: isBeginner,
          );
          widget.onSavedUser(user);
        },
      );
}
