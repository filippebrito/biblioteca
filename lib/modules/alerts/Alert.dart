import 'package:flutter/material.dart';

class Alert{

  GlobalKey<ScaffoldState> _scaffold;
  String _message;
  AlertType _type;

  Alert(
      GlobalKey<ScaffoldState> scaffold,
      String message,
      AlertType type,
      ){
    this._scaffold = scaffold;
    this._message = message;
    this._type = type;
  }

  void show(){
    _scaffold.currentState.showSnackBar(SnackBar(
      content: Text(_message),
      backgroundColor: _getColor(),
    ));
  }

  Color _getColor(){
    if(_type == AlertType.ERROR){
      return Colors.red;
    }else if(_type == AlertType.ALERT){
      return Colors.yellow[800];
    }else{
      return Colors.green;
    }
  }

}

class AlertBuilder{

  GlobalKey<ScaffoldState> _scaffold;
  String _message;
  AlertType _type;

  AlertBuilder scaffold(GlobalKey<ScaffoldState> scaffold){
    this._scaffold = scaffold;
    return this;
  }

  AlertBuilder message(String message){
    this._message = message;
    return this;
  }

  AlertBuilder type(AlertType type){
    this._type = type;
    return this;
  }

  Alert build(){
    return new Alert(
        _scaffold,
        _message,
        _type);
  }
}

enum AlertType{
  SUCCESS,
  ERROR,
  ALERT
}