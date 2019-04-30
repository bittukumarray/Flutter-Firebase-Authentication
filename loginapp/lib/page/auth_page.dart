import 'package:flutter/material.dart';
import './home.dart';
import '../scoped_model/usermodel.dart';
import '../model/user.dart';

class LoginSignUpPage extends StatefulWidget {
  UserModel usermodel = UserModel();

  @override
  State<StatefulWidget> createState() => new _LoginSignUpPageState();
}

enum FormMode { LOGIN, SIGNUP }

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  String _email;
  String _password;
  String _confirm_password;
  String _phone;
  String _name;

  FormMode _formMode = FormMode.LOGIN;
  bool _isLoading = false;
  final _formKey = new GlobalKey<FormState>();

  Widget _showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.orange,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field can\'t be empty';
          }
        },
        onSaved: (value) => _email = value,
      ),
    );
  }

  Widget _showNameInput() {
    return _formMode == FormMode.SIGNUP
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.text,
              autofocus: false,
              decoration: new InputDecoration(
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  hintText: 'Name',
                  icon: new Icon(
                    Icons.person,
                    color: Colors.orange,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field can\'t be empty';
                }
              },
              onSaved: (value) => _name = value,
            ),
          )
        : Container();
  }

  Widget _showNumberInput() {
    return _formMode == FormMode.SIGNUP
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.phone,
              autofocus: false,
              decoration: new InputDecoration(
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  hintText: 'Phone',
                  icon: new Icon(
                    Icons.phone,
                    color: Colors.orange,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field can\'t be empty';
                }
              },
              onSaved: (value) => _phone = value,
            ),
          )
        : Container();
  }

  Widget _showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.orange,
            )),
        validator: (value) {
          if (value.isEmpty) {
            return 'This field can\'t be empty';
          }
        },
        onSaved: (value) => _password = value,
      ),
    );
  }

  Widget _showConfirmPasswordInput() {
    return _formMode == FormMode.SIGNUP
        ? Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
            child: new TextFormField(
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: new InputDecoration(
                  hintStyle: TextStyle(fontSize: 20.0, color: Colors.black),
                  hintText: 'Confirm Password',
                  icon: new Icon(
                    Icons.lock_open,
                    color: Colors.orange,
                  )),
              validator: (value) {
                if (value.isEmpty) {
                  return 'This field can\'t be empty';
                }
              },
              onSaved: (value) => _confirm_password = value,
            ),
          )
        : Container();
  }

  void _submitloginForm() async {
    _formKey.currentState.save();

    final Map<String, dynamic> info =
        await widget.usermodel.UserLogin(_email, _password);

    if (_email.isEmpty || _password.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("No fields should be empty!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else if (!info['hasError']) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage(true)));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("An error occured!"),
              content: Text(info['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  void _submitsignupForm() async {
    _formKey.currentState.save();

    final Map<String, dynamic> info =
        await widget.usermodel.Signin(_email, _password);
    print(info);

    if (_name.isEmpty || _phone.isEmpty || _email.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("No fields should be empty!"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else if (_password != _confirm_password) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Password and Confirm Password are not same"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    } else if (!info['hasError']) {
      widget.usermodel.CreateUser(_name, _email, _phone);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage(true)));
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("An error occured!"),
              content: Text(info['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: new MaterialButton(
            elevation: 5.0,
            minWidth: 200.0,
            height: 42.0,
            color: Colors.pink[100],
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: () {
              print("pressed");
              _isLoading = _isLoading == true ? false : true;
              if (_formMode == FormMode.SIGNUP) {
                // print("in sigin");
                // _showCircularProgress();
                _submitsignupForm();
              } else {
                print("In ,login");
                _submitloginForm();
                // setState(() {
                //   this._isLoading = true;
                // });
                // _showCircularProgress();
              }
            }));
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.SIGNUP
          ? new Text('Already have an Account? Login',
              style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black))
          : new Text('Don\'t have any account? Register',
              style: new TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w300,
                  color: Colors.black)),
      onPressed: () {
        // _submitsignupForm();
        setState(() {
          _formMode =
              _formMode == FormMode.LOGIN ? FormMode.SIGNUP : FormMode.LOGIN;
        });
      },
    );
  }

  Widget _showSkipAuthButton() {
    return _formMode == FormMode.LOGIN
        ? new FlatButton(
            child: new Text('Skip Login',
                style: new TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    color: Colors.orangeAccent)),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => HomePage(false)));
            },
          )
        : Container();
  }

  Widget _showCircularProgress() {
    print("In Circular");
    print(_isLoading);
    if (_isLoading) {
      print("In Circular if");
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.blueGrey,
      ));
    }

    return Container(
      child: Text("data"),
    );
  }

  Widget _showBody() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _showLogo(),
              _showNameInput(),
              _showEmailInput(),
              _showNumberInput(),
              _showPasswordInput(),
              _showConfirmPasswordInput(),
              _showPrimaryButton(),
              _showSecondaryButton(),
              _showSkipAuthButton(),
              // _showErrorMessage(),
            ],
          ),
        ));
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 70.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/flutter.png'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter login demo"),
      ),
      body: Stack(
        // padding: EdgeInsets.all(10),
        children: <Widget>[
          _showBody(),
          // _showCircularProgress(),
        ],
      ),
    );
  }
}
