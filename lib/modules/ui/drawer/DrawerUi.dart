import 'package:flutter/material.dart';

class DrawerUI {

  DrawerItem _header;
  List<DrawerItem> _listMenu;

  DrawerUI(
      BuildContext context,
      {
        DrawerItem header,
        List<DrawerItem> listMenu
      }
  ) {
    this._header = header;
    this._listMenu = listMenu;
  }

  Widget open() {
    return Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: _getItems(),
        )

    );
  }

  List<Widget> _getItems(){
    List<Widget> list = [];

    if(_header != null){
      list.add(
          DrawerHeader(
            child: Text(_header.title),
            decoration: BoxDecoration(
              color: Colors.green,
            ),
          ));
    }

    for(int i = 0; i < _listMenu.length; i++){
      if(_listMenu[i].showDrawer) {
        list.add(
            ListTile(
              leading: _listMenu[i].icon != null ? _listMenu[i].icon : null,
              title: Text(_listMenu[i].title),
              subtitle: _listMenu[i].subtitle != null ? Text(_listMenu[i].subtitle) : null,
              onTap: _listMenu[i].callback,
            )
        );
        if(i+1 < _listMenu.length) {
          list.add(Divider());
        }
      }
    }

    return list;
  }
}

class DrawerItem{
  String title;
  String route;
  Function callback;
  WidgetBuilder redirect;
  bool showDrawer;
  bool showRoute;
  Icon icon;
  String subtitle;

  DrawerItem(this.title, {this.route, this.callback, this.redirect, this.showDrawer:true, this.showRoute:true, this.icon, this.subtitle});
}

class DrawerBuilder {
  BuildContext _context;
  DrawerItem _header;
  List<DrawerItem> _listMenu;

  DrawerBuilder context(BuildContext context){
    this._context = context;
    return this;
  }

  DrawerBuilder header(DrawerItem header){
    this._header = header;
    return this;
  }

  DrawerBuilder menus(List<DrawerItem> listMenu){
    this._listMenu = listMenu;
    return this;
  }

  DrawerBuilder menuAdd(DrawerItem menu){
    if(this._listMenu == null){
      this._listMenu = [];
    }
    this._listMenu.add(menu);
    return this;
  }

  DrawerUI build(){
    return new DrawerUI(
        _context,
        header:_header,
        listMenu: _listMenu);
  }
}