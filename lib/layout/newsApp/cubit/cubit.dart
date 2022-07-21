import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/newsApp/cubit/states.dart';
import 'package:flutter_application_2/modules/business/business_screen.dart';
import 'package:flutter_application_2/modules/science/science_scraan.dart';
import 'package:flutter_application_2/modules/sports/sports_screen.dart';
import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Scinece',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  void changeIndex(int index) {
    currentIndex = index;
    if (currentIndex == 1) getSports();
    if (currentIndex == 2) getScience();

    emit(NewsChangeNavBarStates());
  }

  void getBusiness() {
    if (business.isEmpty) {
      emit(NewsGetBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '4d4c136b0be24dfabaacac6f0fe08df1',
        },
      ).then((value) {
        // print(value.data['articles'][0]['publishedAt'].toString());
        business = value.data['articles'];
        print(business[0]['title']);
        emit(NewsGetBusinessSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorState(error.toString()));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  void getSports() {
    if (sports.isEmpty) {
      emit(NewsGetSportsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '4d4c136b0be24dfabaacac6f0fe08df1',
        },
      ).then((value) {
        // print(value.data['articles'][0]['publishedAt'].toString());
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

  void getScience() {
    if (science.isEmpty) {
      emit(NewsGetScienceLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '4d4c136b0be24dfabaacac6f0fe08df1',
        },
      ).then((value) {
        // print(value.data['articles'][0]['publishedAt'].toString());
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];
  void getSearch(String value) {
    // if (value == '') {
    //   emit(NewsGetSearchLoadingState());
    //   search = [];
    //   print('value is empty');
    // } else {
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '4d4c136b0be24dfabaacac6f0fe08df1',
      },
    ).then((value) {
      // print(value.data['articles'][0]['publishedAt'].toString());
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
//}
