import 'package:brewcrew/screens/home/edit_form.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/screens/home/brew_list.dart';
import 'package:brewcrew/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showPanelEdit(){
      showModalBottomSheet(
          context: context,
          builder: (context){
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: FormEdit(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          title: Text('Home'),
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async{
                  await AuthService().signOut();
                },
                icon: Icon(Icons.person,
                color: Colors.brown[100]),
                label: Text('LogOut',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.brown[100]
                ),))
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover
            )
          ),
          child: BrewList(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.brown,
          child: Icon(Icons.edit),
          onPressed: _showPanelEdit
        ),
      ),
    );
  }


}
