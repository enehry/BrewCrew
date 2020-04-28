import 'package:flutter/material.dart';

const kTextInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 0.0),
    borderRadius: BorderRadius.all(Radius.zero),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0,color: Colors.brown),
    borderRadius: BorderRadius.all(Radius.zero),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0, color: Colors.red),
    borderRadius: BorderRadius.all(Radius.zero),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderSide: BorderSide(width: 2.0, color: Colors.red),
    borderRadius: BorderRadius.all(Radius.zero),
  ),
);