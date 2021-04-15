import 'package:biblioteca/modules/ui/drawer/MenuFactory.dart';
import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Library Routes',
  initialRoute: '/',
  routes: MenuFactory().createRoutes(),
));