import 'package:flutter/material.dart';

class User extends StatefulWidget {
  @override
  UserState createState() {
    return new UserState();
  }
}

class UserState extends State<User> with AutomaticKeepAliveClientMixin {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    print('UserState initState');
  }

  @override
  void dispose() {
    super.dispose();
    print('UserState dispose');
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('You\'re login now'),
            RaisedButton(
              child: Text('SIGN OUT'),
              onPressed: () {
                setState(() {
                  isLogin = false;
                });
              },
            ),
          ],
        ),
      );
    } else {
      return Login(
        loginFunc: login,
      );
    }
  }

  @override
  bool get wantKeepAlive => true;

  login() {
    setState(() {
      isLogin = true;
    });
  }
}

class Login extends StatefulWidget {
  final Function loginFunc;

  const Login({Key key, this.loginFunc}) : super(key: key);

  @override
  LoginState createState() {
    return new LoginState();
  }
}

class LoginState extends State<Login> {
  final _loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          loginHeader(context),
          SizedBox(height: 24.0),
          loginForm(context),
        ],
      ),
    );
  }

  loginHeader(context) => Column(
        children: <Widget>[
          FlutterLogo(
            colors: Colors.indigo,
            size: 80.0,
          ),
          SizedBox(height: 16.0),
          Text('Sign in to continue',),
        ],
      );

  loginForm(context) => Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: _loginFormKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                labelText: "Username *",
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return '';
                }
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: Icon(Icons.visibility_off),
                labelText: "Password *",
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text("SIGN IN"),
                onPressed: () {
                  if (_loginFormKey.currentState.validate()) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Processing Data')));
                    widget.loginFunc();
                  }
                },
              ),
            ),
          ],
        ),
      ));
}
