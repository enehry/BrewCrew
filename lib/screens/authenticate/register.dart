import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constant.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey  = GlobalKey<FormState>();
  bool showLoading = false;

  String _email;
  String _pass;
  String error = '';

  @override
  Widget build(BuildContext context) {

    return showLoading? Loading():Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Register to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: widget.toggleView,
              icon: Icon(Icons.person,
                  color: Colors.brown[100]),
              label: Text('SignIn',
                style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.brown[100]
          ))),
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (email) {_email = email.trim();},
                  decoration: kTextInputDecoration.copyWith(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email,
                    color: Colors.brown[400]),
                  ),
                  validator: (val) => val.isEmpty ? 'Enter an Email':null,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                TextFormField(
                    onChanged: (pass) { _pass = pass.trim(); },
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Password too short':null,
                    decoration: kTextInputDecoration.copyWith(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key,
                          color: Colors.brown[400]),
                    ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(error, style: TextStyle(
                      color:  Colors.red,
                    )),
                    SizedBox(width: 10),
                    RaisedButton(
                      onPressed: () async{
                          if(_formKey.currentState.validate()){
                            setState(() => showLoading = true);
                           dynamic result = await _auth.registerEmail(_email, _pass);
                           if(result == null){
                             setState(() {
                               error = 'please supply a valid email';
                               showLoading = false;
                             });
                           }
                          }
                      },
                      color: Colors.brown,
                      child: Text('Register',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0
                          )),
                    ),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }
}
