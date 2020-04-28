import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/constant.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String _error = '';
  String _email;
  String _pass;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold (
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: widget.toggleView,
              icon: Icon(Icons.person,
                  color: Colors.brown[100]),
              label: Text('Register',
                style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.brown[100]
          ),))
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
                validator: (val) => val.isEmpty ? 'Please enter your email' : null,
                keyboardType: TextInputType.emailAddress,
                onChanged: (email) {_email = email.trim();},
                decoration: kTextInputDecoration.copyWith(
                  prefixIcon: Icon(Icons.email,
                  color: Colors.brown[400]),
                  hintText: 'Email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Please enter your password' : null,
                onChanged: (pass) { _pass = pass.trim(); },
                  obscureText: true,
                  decoration: kTextInputDecoration.copyWith(
                    prefixIcon: Icon(Icons.vpn_key,
                        color: Colors.brown[400]),
                    hintText: 'Password',
                  ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(_error, style: TextStyle(
                    color:  Colors.red,
                  )),
                  SizedBox(width: 10),
                  RaisedButton(
                    onPressed: () async{
                      if(_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.signInEmail(_email, _pass);
                        if(result == null){
                          setState(() {
                            loading = false;
                            _error = 'INVALID EMAIL OR PASSWORD';
                          });
                        }
                      }

                    },
                    color: Colors.brown,
                    child: Text('Sign In',
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
