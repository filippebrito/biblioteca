
import 'package:biblioteca/book/model/Book.dart';
import 'package:biblioteca/book/presenter/BookPresenter.dart';
import 'package:flutter/material.dart';

class ListAdapter{

  static List<Widget> listBook(List<Book> books, { BookPresenter presenter }){
    List<Widget> listWidget = [];
    for(int i=0; i<books.length; i++) {
      listWidget.add(
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(books[i].name,
                style:
                  TextStyle(color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0)),
                Icon(
                  Icons.more_vert,
                  color: Colors.blueGrey,
                )
              ]
            ),
            onTap: (){ presenter.openBottomSheet(books[i]); },
            //onLongPress: (){ presenter.openTextDialog(books[i]); },
      ));
    }

    return listWidget;
  }

}