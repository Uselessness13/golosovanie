import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnackBarsCubit extends Cubit<String> {
  static final SnackBarsCubit _singleton = SnackBarsCubit._internal();

  factory SnackBarsCubit() => _singleton;

  SnackBarsCubit._internal() : super(null);

  void showSnackBar(String string) {
    emit(string);
  }
}
