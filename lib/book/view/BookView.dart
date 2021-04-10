
import 'package:biblioteca/book/model/Book.dart';
import 'package:biblioteca/book/presenter/BookPresenter.dart';
import 'package:biblioteca/modules/ui/dialog/Dialog.dart';
import 'package:biblioteca/modules/ui/dialog/enum/DialogType.dart';
import 'package:biblioteca/modules/ui/list/ListAdapter.dart';
import 'package:flutter/material.dart';


abstract class BookView{
  void updateBooks(List<Book> books);
  void updateDialogText(String text);
  void updateBook(Book book);
  Future<void> openDialog({DialogType type: DialogType.INSERT, Book book});
  Future<void> openTextDialog(Book book);
  void closeDialog();
}

class BookViewImpl extends StatefulWidget {

  final BookPresenter presenter;
  BookViewImpl(this.presenter, {Key key}) : super(key: key);

  @override
  _BookView createState() => _BookView();
}

class _BookView extends State<BookViewImpl> implements BookView{


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _textFieldController = TextEditingController();
  List<Widget> _listBooks = [];
  BuildContext context;
  Book _book;

  @override
  void initState() {
    super.initState();
    this.widget.presenter.setView(this);
  }

  @override
  void updateDialogText(String text){
    setState(() {
      _textFieldController.text = text;
    });
  }

  @override
  void closeDialog(){
    setState(() {
      Navigator.pop(context);
    });
  }

  @override
  void updateBook(Book book){
    setState(() {
      _book = book;
    });
  }

  @override
  void updateBooks(List<Book> books){
    setState(() {
      _listBooks = ListAdapter.listBook(
          books,
          presenter: this.widget.presenter
      );
    });
  }

  @override
  Future<void> openDialog({DialogType type: DialogType.INSERT, Book book}) async {

    return DialogBuilder()
        .context(context)
        .title("Book")
        .textFieldController(_textFieldController)
        .hintText("Name of book")
        .buttonCancel(new DialogButton('CANCEL', this.widget.presenter.cleanCloseDialog))
        .buttonOk(new DialogButton('OK', (){ this.widget.presenter.insertEdit(type, _book); }))
        .onChange((value) { this.widget.presenter.updateName(book, value);})
        .build()
        .open();
  }

  @override
  Future<void> openTextDialog(Book book) async {
    return DialogBuilder()
        .context(context)
        .title("Book")
        .question("Are you craze man?")
        .buttonCancel(new DialogButton('CANCEL', this.widget.presenter.cleanCloseDialog))
        .buttonOk(new DialogButton('OK', (){ this.widget.presenter.delete(_book); }))
        .build()
        .open();
  }

  MaterialApp _initView() {
    this.widget.presenter.select();
    return MaterialApp(
        title: 'Books',
        home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('List of Books'),
            backgroundColor: Colors.green,
            actions: [IconButton(icon: const Icon(Icons.add),
                            tooltip: 'Insert',
                            onPressed: this.widget.presenter.openDialog)],
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: _listBooks.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: _listBooks[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider()
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return this._initView();
  }
  
}