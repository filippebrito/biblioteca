
import 'package:biblioteca/book/model/Book.dart';
import 'package:biblioteca/book/presenter/BookPresenter.dart';
import 'package:biblioteca/modules/alerts/Alert.dart';
import 'package:biblioteca/modules/bottomsheet/BottomSheetComponent.dart';
import 'package:biblioteca/modules/ui/appbar/Appbar.dart';
import 'package:biblioteca/modules/ui/dialog/Dialog.dart';
import 'package:biblioteca/modules/ui/dialog/enum/DialogType.dart';
import 'package:biblioteca/modules/ui/drawer/DrawerUi.dart';
import 'package:biblioteca/modules/ui/drawer/MenuFactory.dart';
import 'package:biblioteca/modules/ui/list/ListAdapter.dart';
import 'package:flutter/material.dart';

abstract class BookView{
  void updateBooks(List<Book> books);
  void updateDialogText(String text);
  void updateBook(Book book);
  Future<void> openDialog({DialogType type: DialogType.INSERT, Book book});
  Future<void> openTextDialog(Book book);
  void openBottomSheet(Book book);
  void closeDialog();
  void showMessage(String message, AlertType type);
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
  void showMessage(String message, AlertType type){
    AlertBuilder()
        .scaffold(_scaffoldKey)
        .message(message)
        .type(type)
        .build()
        .show();
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
        .buttonOk(new DialogButton('OK', (){ this.widget.presenter.delete(book); }))
        .build()
        .open();
  }

  Widget _getDrawer(){
    return DrawerBuilder()
        .context(context)
        .header( DrawerItem("Drawer Header"))
        .menus(MenuFactory().createMenu(context))
        .build()
        .open();
  }

  Widget _getBody(){
    if(_listBooks.length > 0){
      return ListView.separated(
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
      );
    }else{
      return Center(
          child: Image.asset(
          "images/no-result.png",
        )
      );
    }
  }

  @override
  void openBottomSheet(Book book) {
    BottomSheetComponent bottomSheet = BottomSheetComponent(
        context,
        book.name,
        listItems: [
          new BottomSheetItems(
              'Edit',
              icon:Icons.edit,
              onTap: () {
                this.widget.presenter.closeDialog();
                this.widget.presenter.openDialog(type: DialogType.EDIT , book: book);
              },
          ),
          new BottomSheetItems(
            'Delete',
            icon:Icons.delete,
            color: Colors.red,
            onTap: () {
              this.widget.presenter.closeDialog();
              this.widget.presenter.openTextDialog(book);
            },
          )
        ]
    );
    bottomSheet.show();
  }

  Widget _getAppbar(){
    return AppbarBuilder()
        .title('List of Books')
        .actions([new AppbarActionItens(Icon(Icons.add), "Insert", this.widget.presenter.openDialog)])
        .builder()
        .show();

  }

  MaterialApp _initView() {
    this.widget.presenter.select();
    return MaterialApp(
        debugShowCheckedModeBanner:false,
        title: 'Books',
        home: Scaffold(
          key: _scaffoldKey,
          appBar: _getAppbar(),
          body: _getBody(),
          drawer: _getDrawer(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    if(this.widget.presenter.getView() == null) {
      this.widget.presenter.setView(this);
    }
    return this._initView();
  }
  
}