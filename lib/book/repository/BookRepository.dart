import 'package:biblioteca/book/model/Book.dart';
import 'package:biblioteca/modules/database/BaseRepository.dart';

class BookRepository extends BaseRepository{
  static const String DB_NAME = "book";

  BookRepository() : super();

  void insert(Book book) async {
    String sql = "INSERT INTO $DB_NAME(name) VALUES('" + book.name + "')";
    book.id = await insertDB(sql);
  }

  void update(Book book) async {
    int id = book.id;
    String name = book.name;

    String sql = "UPDATE $DB_NAME SET name = '$name' WHERE id = $id";
    await updateDB(sql);
  }

  void delete(Book book) async {
    int id = book.id;

    String sql = "DELETE FROM $DB_NAME WHERE id = $id";
    await deleteDB(sql);
  }

  Future<List<Book>> getAll() async {

    List<Book> books = [];

    String sql = "SELECT * FROM $DB_NAME ORDER BY name";
    List<Map> list = await selectDb(sql);

    for(int i=0; i<list.length; i++){
      books.add(Book.fromMap(list[i]));
    }

    return books;
  }

}