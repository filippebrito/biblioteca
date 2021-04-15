import 'package:flutter/material.dart';

class AppbarUI{

  String _title;
  List<AppbarActionItens> _actions;

  AppbarUI(String title, {List<AppbarActionItens> actions}){
    this._title = title;
    this._actions = actions;
  }

  Widget show(){
    return AppBar(
      title: Text(_title),
      backgroundColor: Colors.green,
      actions: _getActions(),
    );
  }

  List<Widget> _getActions(){
    List<Widget> list = [];
    for(int i=0; i < _actions.length; i++) {
      list.add(IconButton(icon: _actions[i].icon,
          tooltip: _actions[i].tooltip,
          onPressed: _actions[i].onpressed));
    }
    return list;
  }
}

class AppbarActionItens{

  Widget icon;
  String tooltip;
  Function onpressed;

  AppbarActionItens(this.icon, this.tooltip, this.onpressed);

}

class AppbarBuilder {

  String _title;
  List<AppbarActionItens> _actions;

  AppbarBuilder title(String title){
    this._title = title;
    return this;
  }

  AppbarBuilder actions(List<AppbarActionItens> actions){
    this._actions = actions;
    return this;
  }

  AppbarUI builder(){
    return AppbarUI(_title, actions: _actions);
  }

}