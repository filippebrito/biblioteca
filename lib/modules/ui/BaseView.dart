import 'package:flutter/material.dart';

abstract class BaseView{
  Widget getAppbar();
  Widget getBody();
  Widget getDrawer();
}