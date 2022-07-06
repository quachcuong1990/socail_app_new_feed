import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:socail/modules/categories/models/categories.dart';
import 'package:socail/modules/categories/repository/list_categories_repo.dart';

import '../models/category.dart';
class ListCategoriesBloc extends Bloc<String, ListCategoriesState>{
  ListCategoriesBloc(): super(ListCategoriesState()){
    on<String>((event,emit)async{
      switch(event){
        case 'getCategories':
          try{
            final res = await ListCategoriesRepo().getCategories();
            if(res!=null){
              emit(ListCategoriesState(categories: res));
            }
          }catch(e){
            emit(ListCategoriesState(error: e));
          }
          break;
        default:
            await _search(event, emit);

      }
    },
        transformer: debounce(const Duration(milliseconds: 100)),
    );
  }
  Future<void> _search(String query, Emitter<ListCategoriesState> emit) async {
    if (query.isEmpty) {
      return;
    }
  }


}
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}


class ListCategoriesState {
  final Object? error;
  final List<Category>? categories;

  final List<String>? tagList;
  final String? tagQuery;

  ListCategoriesState({
    this.error,
    this.categories,
    this.tagList,
    this.tagQuery,
  });

  ListCategoriesState copyWith({
    Object? error,
    List<Category>? categories,
    List<String>? tagList,
    String? tagQuery,
  }) =>
      ListCategoriesState(
        error: error ?? this.error,
        categories: categories ?? this.categories,
        tagList: tagList ?? this.tagList,
        tagQuery: tagQuery ?? this.tagQuery,
      );
}
