
import 'package:biblioteca/settings/repository/SettingsRepository.dart';
import 'package:biblioteca/settings/view/SettingsView.dart';

abstract class SettingsPresenter{
  SettingsView getView();
  void setView(SettingsView view);
  void changeNotification(bool value);
  void getChangeNotification();
}


class SettingsPresenterImpl implements SettingsPresenter{

  SettingsView view;
  SettingsRepository repository;

  SettingsPresenterImpl(){
    this.repository = SettingsRepository();
  }

  @override
  SettingsView getView(){
    return this.view;
  }

  @override
  void setView(SettingsView view){
    this.view = view;
  }

  @override
  void changeNotification(bool value) async {
    repository.insertBool("receivedNotification", value);
    this.view.changeNotification(value);
  }

  @override
  void getChangeNotification() async {
    bool value = await repository.getBool("receivedNotification");
    if(value != null) {
      changeNotification(value);
    }
  }
}