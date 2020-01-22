import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../widgets/ui/auth_mode_switch_btn.dart";
import "../widgets/ui/custom_btn.dart";
import "../providers/auth.dart";
import '../models/user.dart';
import '../utils/http_exception.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: AuthForm(deviceSize: deviceSize),
        ),
      ),
    );
  }
}

enum AuthMode {
  SignUp,
  SignIn,
}

class AuthForm extends StatefulWidget {
  final deviceSize;
  AuthForm({@required this.deviceSize});
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.SignIn;
  bool _isLoading = false;

  TextEditingController _passwordController = TextEditingController();
  User _userData = User(
    email: "",
    firstName: "",
    lastName: "",
    password: "",
    username: "",
  );

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _switchAuthMode() {
    _passwordController = TextEditingController();
    // _passwordController.dispose();
    if (_authMode == AuthMode.SignUp) {
      setState(() {
        // _passwordController.clear();
        _authMode = AuthMode.SignIn;
      });
    } else {
      setState(() {
        // _passwordController.clear();
        _authMode = AuthMode.SignUp;
      });
    }
  }

  void _showErrDialog(String errMsg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(errMsg),
        title: Text("Error Occured"),
        actions: <Widget>[
          FlatButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    // print(
    //     "firstName: ${_userData.firstName}, lastName: ${_userData.lastName}, email: ${_userData.email}, username: ${_userData.username}, password: ${_userData.password}");
    // print("Submitted");
    this.setState(() {
      _isLoading = true;
    });
    if (_authMode == AuthMode.SignUp) {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signUp(_userData.toSignUpJson());
      } on HttpException catch (err) {
        _showErrDialog(err.toString());
      } catch (err) {
        _showErrDialog("Could not authenticate you. Please try again later.");
      }
    } else {
      try {
        await Provider.of<Auth>(context, listen: false)
            .signIn(_userData.toSignInJson());
      } on HttpException {
        _showErrDialog("Username/Password is not valid!");
      } catch (err) {
        _showErrDialog("Could not authenticate you. Please try again later.");
      }
    }
    this.setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 60.0,
          width: widget.deviceSize.width * 0.8,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
          ),
          child: FittedBox(
            child: Text(
              _authMode == AuthMode.SignIn ? "SIGN IN" : "SIGN UP",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: Theme.of(context).textTheme.display1.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
          padding: const EdgeInsets.all(10.0),
          height: _authMode == AuthMode.SignUp ? 350.0 : 250.0,
          width: widget.deviceSize.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Username",
                        border: OutlineInputBorder(),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Username can't be empty";
                        }
                        return null;
                      },
                      onSaved: (String value) {
                        _userData.username = value.trim();
                      },
                    ),
                  ),
                  if (_authMode == AuthMode.SignUp)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                          validator: (String value) {
                            final emRegex = RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
                            if (value.isEmpty) {
                              return "Email can't be empty";
                            } else if (!emRegex.hasMatch(value)) {
                              return "Enter a valid email.";
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _userData.email = value.trim();
                          }),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return "Password can't be empty.";
                          }
                          return null;
                        },
                        onSaved: (String value) {
                          _userData.password = value.trim();
                        }),
                  ),
                  if (_authMode == AuthMode.SignUp)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm password",
                          border: OutlineInputBorder(),
                        ),
                        validator: _authMode == AuthMode.SignUp
                            ? (String value) {
                                if (_passwordController.text != "" &&
                                    value != _passwordController.text) {
                                  return "Password doesn't match.";
                                }
                                return null;
                              }
                            : null,
                        onSaved: (String value) {
                          _userData.password = value.trim();
                        },
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: AuthModeSwitchBtn(
                          title: _authMode == AuthMode.SignUp
                              ? "Already have an account?"
                              : "Create an account?",
                          onPressed: _switchAuthMode,
                        ),
                      ),
                      _isLoading
                          ? Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              backgroundColor: Theme.of(context).primaryColor,
                              label: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                              ),
                            )
                          : CustomBtn(
                              title: _authMode == AuthMode.SignUp
                                  ? "Sign Up"
                                  : "Sign In",
                              iconData: _authMode == AuthMode.SignUp
                                  ? Icons.account_box
                                  : Icons.arrow_forward_ios,
                              onPressed: _onSubmit,
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
