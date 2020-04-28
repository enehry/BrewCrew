import 'package:brewcrew/screens/home/brew_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brewcrew/models/brew.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override



  Widget build(BuildContext context) {
    var brews = Provider.of<List<Brew>>(context);

    if(brews != null){
    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context, index){
          return BrewTile(brew: brews[index]);
        }
    );
    }
    else{
      return Container(
        child: Text('No Data Retreive'),
      );
    }
  }
}

