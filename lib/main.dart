import 'package:biblioteca/book/presenter/BookPresenter.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca/book/view/BookView.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Library Routes',
  initialRoute: '/',
  routes: {
    '/': (context) => BookViewImpl(BookPresenterImpl())
  },
));