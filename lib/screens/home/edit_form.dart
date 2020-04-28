import 'package:brewcrew/models/user.dart';
import 'package:brewcrew/services/database.dart';
import 'package:brewcrew/shared/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormEdit extends StatefulWidget {
  @override
  _FormEditState createState() => _FormEditState();
}

class _FormEditState extends State<FormEdit> {

  final _formKey = GlobalKey<FormState>();
  final List<String> _sugars = ['0','1','2','3','4'];

  String _curName;
  String _curSugar;
  int _curStr;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Container(
        child: StreamBuilder<UserData>(
          stream: DatabaseService(uid: user.uid).userData,
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                        color: Colors.brown,
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Text('Edit your brew',
                          style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2.0
                          ),)),
                    SizedBox(height: 15.0,),
                    TextFormField(
                      initialValue: _curName ?? snapshot.data.name,
                      validator: (val) => val.isEmpty ? 'Please enter your name': null,
                      onChanged: (name) => _curName = name,
                      decoration: kTextInputDecoration.copyWith(
                          contentPadding: EdgeInsets.symmetric(vertical: 0.0,),
                          prefixText: '  Name : ',
                          prefixStyle: TextStyle(
                            color: Colors.brown,
                          )
                      ),
                    ),
                    SizedBox(height: 20.0),
                    //Slider
                    DropdownButtonFormField(
                      value: _curSugar ?? snapshot.data.sugars,
                      decoration: kTextInputDecoration.copyWith(
                        contentPadding: EdgeInsets.symmetric(vertical: 0.0,horizontal: 15.0),
                      ),
                      items: _sugars.map((sugar){
                        return DropdownMenuItem(
                          value: sugar,
                          child: Text('$sugar sugars'),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          _curSugar = val;
                        });
                      },

                    ),
                    //Dropdown
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.brown[_curStr??snapshot.data.strength],
                        inactiveTrackColor: Colors.brown[100],
                        trackShape: RoundedRectSliderTrackShape(),
                        trackHeight: 4.0,
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                        thumbColor: Colors.brown[_curStr??snapshot.data.strength],
                        overlayColor: Colors.brown.withAlpha(32),
                        overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                        tickMarkShape: RoundSliderTickMarkShape(),
                        activeTickMarkColor: Colors.brown[_curStr??snapshot.data.strength],
                        inactiveTickMarkColor: Colors.brown[100],
                        valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.brown[600],
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      child: Slider(
                        label: 'Brew Strength',
                        value: (_curStr??snapshot.data.strength).toDouble(),
                        min: 100,
                        max: 900,
                        divisions: 8,
                        onChanged: (val)=> setState(()=> _curStr = val.toInt() ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.brown,
                      child: Text('Update',
                          style: TextStyle(
                              color: Colors.white
                          )),
                      onPressed: ()async{
                        if(_formKey.currentState.validate()){
                          await DatabaseService(uid: user.uid)
                              .updateUserData(
                              _curSugar ?? snapshot.data.sugars,
                              _curName ?? snapshot.data.name,
                              _curStr ?? snapshot.data.strength);
                          Navigator.pop(context);
                        }
                      },
                    )
                  ],
                ),
              );
            }
            else{
              return Text('No Data retieve');
            }
          }

        ),
    );
  }
}
