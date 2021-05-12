import 'package:biblioteca/book/view/BookView.dart';
import 'package:biblioteca/modules/ui/drawer/DrawerUi.dart';
import 'package:biblioteca/settings/presenter/SettingsPresenter.dart';
import 'package:biblioteca/settings/view/SettingsView.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca/book/presenter/BookPresenter.dart';


class MenuFactory{

  List<DrawerItem> _list = [];
  Map<String, WidgetBuilder> routes = new Map();

  List<DrawerItem> createMenu(BuildContext context){

    _list.add(
        DrawerItem(
            "Category",
            route: "/category",
            callback: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/category");
            },
            redirect: (context) => BookViewImpl(BookPresenterImpl()),
            subtitle: "Category crud",
            icon: Icon(Icons.category)
            )
    );
    _list.add(
        DrawerItem(
            "Author",
            route: "/author",
            callback: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/author");
            },
            redirect: (context) => BookViewImpl(BookPresenterImpl()),
            subtitle: "Author crud",
            icon: Icon(Icons.edit)
            )
    );
    _list.add(
        DrawerItem(
            "Books",
            route: "/",
            callback: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/");
            },
            redirect: (context) => BookViewImpl(BookPresenterImpl()),
            subtitle: "books crud",
            icon: Icon(Icons.book)
        )
    );
    _list.add(
        DrawerItem(
            "Settings",
            route: "/settings",
            callback: (){
              Navigator.pop(context);
              Navigator.pushNamed(context, "/settings");
            },
            redirect: (context) => SettingsViewImpl(SettingsPresenterImpl()),
            icon: Icon(Icons.settings)
        )
    );

    return _list;
  }

  Map<String, WidgetBuilder> createRoutes() {
    createMenu(null);
    for(int i = 0; i < _list.length; i++) {
      if(_list[i].showRoute) {
        routes[_list[i].route] = _list[i].redirect;
      }
    }
    return routes;
  }

}