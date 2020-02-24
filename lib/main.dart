import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Input boxes',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: InputBox(),
    );
  }
}

class InputBox extends StatefulWidget {
  @override
  InputBoxState createState() => InputBoxState();
}

class InputBoxState extends State<InputBox> {
  bool loggedIn = false;
  String _email, _userName, _password;

  final formKey = GlobalKey<FormState>();
  final mainKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: mainKey,
      appBar: AppBar(title: Text("Form Example")),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: loggedIn == false ? Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Email: "),
                validator: (str) =>
                    !str.contains('@') ? "Not a Valid Email!" : null,
                onSaved: (str) => _email = str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Username: "),
                validator: (str) =>
                    str.length <= 5 ? "Not a Valid Username!" : null,
                onSaved: (str) => _userName = str,
              ),
              TextFormField(
                autocorrect: false,
                decoration: InputDecoration(labelText: "Password: "),
                validator: (str) =>
                    str.length <= 7 ? "Not a Valid Password!" : null,
                onSaved: (str) => _password = str,
                obscureText: true,
              ),
              RaisedButton(
                child: Text("Submit"),
                onPressed: onPressed,
              ),
            ],
          ),
        ) : Center (
          child: Column(
            children: <Widget>[
              Text("Welcome $_userName"),
              RaisedButton(
                child: Text("Log Out"),
                onPressed: () {
                  setState(() {
                    loggedIn = false;
                  });
                } ,
              )
            ],
          ),
        )
      ),
    );
  }

  void onPressed() {
    var form = formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        loggedIn = true;
      });

      var snackBar = SnackBar(
        content: Text(
          "Username: $_userName, Email: $_email, Password: $_password"
        ),
        duration: Duration(milliseconds: 5000),
      );

      mainKey.currentState.showSnackBar(snackBar);
    }
  }
}
