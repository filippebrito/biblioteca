import 'package:flutter/material.dart';

class DialogUI{

  String _title;
  BuildContext _context;
  TextEditingController _textFieldController;
  String _hintText;
  String _question;
  DialogButton _buttonCancel;
  DialogButton _buttonOk;
  Function _onChange;

  DialogUI(BuildContext context, {
    String title: "",
    TextEditingController textFieldController,
    String hintText,
    String question,
    DialogButton buttonCancel,
    DialogButton buttonOk,
    Function onChange
  }){
    this._context = context;
    this._title = title;
    this._textFieldController = textFieldController;
    this._hintText = hintText;
    this._question = question;
    this._buttonCancel = buttonCancel;
    this._buttonOk = buttonOk;
    this._onChange = onChange;
  }

  Future<void> open() async {

    return showDialog(
        context: _context,
        builder: (context) {
          return AlertDialog(
            title: Text(_title),
            content: _getContent(),
            actions: <Widget>[
              TextButton(
                child: Text(_buttonCancel.title),
                onPressed: _buttonCancel.callback,
              ),
              TextButton(
                child: Text(_buttonOk.title),
                onPressed: _buttonOk.callback,
              ),

            ],
          );
        });
  }

  Widget _getContent(){

    if(_question != null){
      return Text(_question);
    }else{
      return TextField(
        onChanged: _onChange,
        controller: _textFieldController,
        decoration: InputDecoration(hintText: _hintText),
      );
    }

  }

}

class DialogBuilder{
  String _title;
  BuildContext _context;
  TextEditingController _textFieldController;
  String _hintText;
  String _question;
  DialogButton _buttonCancel;
  DialogButton _buttonOk;
  Function _onChange;

  DialogBuilder context(BuildContext context){
    this._context = context;
    return this;
  }

  DialogBuilder title(String title){
    this._title = title;
    return this;
  }

  DialogBuilder textFieldController(TextEditingController textFieldController){
    this._textFieldController = textFieldController;
    return this;
  }

  DialogBuilder hintText(String hintText){
    this._hintText = hintText;
    return this;
  }

  DialogBuilder question(String question){
    this._question = question;
    return this;
  }

  DialogBuilder buttonCancel(DialogButton buttonCancel){
    this._buttonCancel = buttonCancel;
    return this;
  }

  DialogBuilder buttonOk(DialogButton buttonOk){
    this._buttonOk = buttonOk;
    return this;
  }

  DialogBuilder onChange(Function onChange){
    this._onChange = onChange;
    return this;
  }

  DialogUI build(){
    return new DialogUI(
        _context,
        title:_title,
        textFieldController: _textFieldController,
        hintText: _hintText,
        question: _question,
        buttonCancel: _buttonCancel,
        buttonOk: _buttonOk,
        onChange: _onChange);
  }

}

class DialogButton{
  String title;
  Function callback;

  DialogButton(this.title, this.callback);
}