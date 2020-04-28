import 'package:brewcrew/screens/authenticate/authenticate.dart';
import 'package:brewcrew/screens/home/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return (user != null) ? Home() : Authenticate();
  }
}
