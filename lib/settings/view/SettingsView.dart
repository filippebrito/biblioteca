import 'package:biblioteca/modules/ui/BaseView.dart';
import 'package:biblioteca/modules/ui/appbar/Appbar.dart';
import 'package:biblioteca/modules/ui/drawer/DrawerUi.dart';
import 'package:biblioteca/modules/ui/drawer/MenuFactory.dart';
import 'package:biblioteca/settings/presenter/SettingsPresenter.dart';
import 'package:flutter/material.dart';


abstract class SettingsView{
  void changeNotification(bool value);
}

class SettingsViewImpl extends StatefulWidget {

  final SettingsPresenter presenter;
  SettingsViewImpl(this.presenter, {Key key}) : super(key: key);

  @override
  _SettingsView createState() => _SettingsView();
}

class _SettingsView extends State<SettingsViewImpl> implements SettingsView, BaseView {

  BuildContext context;
  bool _receivedNotification = true;

  @override
  void changeNotification(bool value){
    setState(() {
      _receivedNotification = value;
    });
  }

  @override
  Widget getAppbar() {
    return AppbarBuilder()
        .title('Settings')
        .builder()
        .show();
  }

  @override
  Widget getBody() {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        children: [
          Text("Notification settings"),
          SwitchListTile(
              value: _receivedNotification,
              title: Text("Received notification"),
              onChanged: (bool value) { this.widget.presenter.changeNotification(value); } )
        ],
      ),
    );
  }

  @override
  Widget getDrawer() {
    return DrawerBuilder()
        .context(context)
        .header( DrawerItem("Drawer Header"))
        .menus(MenuFactory().createMenu(context))
        .build()
        .open();
  }

  MaterialApp _initView() {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'Books',
      home: Scaffold(
        appBar: getAppbar(),
        body: getBody(),
        drawer: getDrawer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    if(this.widget.presenter.getView() == null) {
      this.widget.presenter.setView(this);
    }
    this.widget.presenter.getChangeNotification();
    return this._initView();
  }
}