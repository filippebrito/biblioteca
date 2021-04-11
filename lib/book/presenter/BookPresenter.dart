import 'package:biblioteca/book/model/Book.dart';
import 'package:biblioteca/book/repository/BookRepository.dart';
import 'package:biblioteca/book/view/BookView.dart';
import 'package:biblioteca/modules/ui/dialog/enum/DialogType.dart';

abstract class BookPresenter {
  void setView(BookView view);
  void openDialog({DialogType type: DialogType.INSERT, Book book});
  void openTextDialog(Book book);
  void cleanCloseDialog();
  void insertEdit(DialogType type, Book book);
  void select();
  void delete(Book book);
  void updateName(Book book, String name);
}

class BookPresenterImpl implements BookPresenter{

  BookView view;
  BookRepository repository;

  BookPresenterImpl(){
    this.repository = BookRepository();
  }

  @override
  void setView(BookView view){
    this.view = view;
  }

  @override
  void openDialog({DialogType type: DialogType.INSERT, Book book}){
    if(type == DialogType.EDIT){
      this.view.updateDialogText(book.name);
    }
    this.view.openDialog(type: type, book: book);
  }

  @override
  void openTextDialog(Book book){
    this.view.openTextDialog(book);
  }

  @override
  void cleanCloseDialog(){
    this.view.updateDialogText("");
    this.view.closeDialog();
  }

  @override
  void insertEdit(DialogType type, Book book){
    if(type == DialogType.EDIT) {
      repository.update(book);
    }else{
      repository.insert(book);
    }
    select();
    cleanCloseDialog();
  }

  @override
  void delete(Book book) async{
    repository.delete(book);
    select();
    cleanCloseDialog();
  }

  @override
  void select() async{
    List<Book> books = await repository.getAll();
    this.view.updateBooks(books);
  }

  @override
  void updateName(Book book, String name){
    if(book == null) {
      book = Book(name: name);
    }
    book.name = name;
    this.view.updateBook(book);
  }

}