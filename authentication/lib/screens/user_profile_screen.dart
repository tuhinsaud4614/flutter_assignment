import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../widgets/ui/custom_container.dart';
import '../widgets/ui/custom_btn.dart';
import '../widgets/ui/custom_text.dart';

class UserProfileScreen extends StatelessWidget {
  static final String routeName = "/user-frofile";

  Future<void> _logOutUser(BuildContext context) async {
    await Provider.of<Auth>(context, listen: false).logOut();
  }

  @override
  Widget build(BuildContext context) {
    print("[_UserProfileScreenState]");
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        title: Consumer<Auth>(
          builder: (context, auth, child) => Text(
              auth.userInfo["user_email"] != ""
                  ? auth.userInfo["username"]
                  : "Unknown"),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.exit_to_app),
            label: Text("Log Out"),
            onPressed: () => _logOutUser(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            CustomContainer(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Image.asset(
                      "assets/img/default_profile.png",
                      color: Theme.of(context).primaryColor,
                      colorBlendMode: BlendMode.color,
                      width: deviceSize.width * .27,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomText(
                            textPair: <String, String>{
                              "First Name": "Md. Tuhin"
                            },
                          ),
                          CustomText(
                            textPair: <String, String>{"Last Name": "Saud"},
                          ),
                          Consumer<Auth>(
                            builder: (context, auth, child) => CustomText(
                              textPair: <String, String>{
                                "Email": auth.userInfo["email"] != ""
                                    ? auth.userInfo["email"]
                                    : "unknown email",
                              },
                            ),
                          ),
                          CustomBtn(
                            iconData: Icons.edit,
                            title: "Update Profile",
                            onPressed: () {
                              Provider.of<Auth>(context, listen: false)
                                  .changeEditMode();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Consumer<Auth>(
              builder: (context, auth, child) {
                if (auth.isEditMode) return UpdateProfile();
                return SizedBox();
              },
            ),
            // UpdateProfile()
          ],
        ),
      ),
    );
  }
}

class UpdateProfile extends StatefulWidget {
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    print("[_UpdateProfileState]");
    return CustomContainer(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "First Name",
                  border: OutlineInputBorder(),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "First name can't be empty";
                  }
                  return null;
                },
                onSaved: (String value) {
                  // _userData.username = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Last Name",
                  border: OutlineInputBorder(),
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Last name can't be empty";
                  }
                  return null;
                },
                onSaved: (String value) {
                  // _userData.username = value;
                },
              ),
            ),
            RaisedButton(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
              child: FittedBox(
                child: Text(
                  "UPDATE",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
