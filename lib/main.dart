import 'package:biblioteca/book/presenter/BookPresenter.dart';
import 'package:flutter/material.dart';
import 'package:biblioteca/book/view/BookView.dart';

void main() => runApp(MaterialApp(
  title: 'Named Routes Demo',
  initialRoute: '/',
  routes: {
    '/': (context) => BookViewImpl(BookPresenterImpl())
  },
));