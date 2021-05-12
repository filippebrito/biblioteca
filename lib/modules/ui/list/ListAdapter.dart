
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
                Row(
                  children: [
                    Image.asset(books[i].image),
                    Padding(padding: EdgeInsets.only(right: 10.0),),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(books[i].name,
                            style:
                            TextStyle(color: Colors.blueGrey,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                        Text("Pages: 120",
                            style:
                            TextStyle(color: Colors.blueGrey.withOpacity(0.6),
                                fontSize: 14.0,
                            )),
                      ],
                    ),
                ]),
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