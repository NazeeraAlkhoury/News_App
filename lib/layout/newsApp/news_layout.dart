import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/newsApp/cubit/cubit.dart';
import 'package:flutter_application_2/modules/search/search_screen.dart';
import 'package:flutter_application_2/shared/components/components.dart';

import 'package:flutter_application_2/shared/cubit/cubit.dart';
//import 'package:flutter_application_2/shared/network/remote/dio_helper.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  NewsCubit.get(context).search = [];
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,
            onTap: (index) {
              cubit.changeIndex(index);
            },
          ),
          body: cubit.screens[cubit.currentIndex],
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     DioHelper.getData(
          //       url: 'v2/top-headlines',
          //       query: {
          //         'country': 'eg',
          //         'category': 'business',
          //         'apiKey': '4d4c136b0be24dfabaacac6f0fe08df1',
          //       },
          //     ).then((value) {
          //       print(value.data['articles'][0]['publishedAt'].toString());
          //     }).catchError((error) {
          //       print(error.toString());
          //     });
          //   },
          //   child: Icon(Icons.add),
          // ),
        );
      },
    );
  }
}
