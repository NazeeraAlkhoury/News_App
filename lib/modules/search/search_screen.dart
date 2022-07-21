import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/newsApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/newsApp/cubit/states.dart';
import 'package:flutter_application_2/shared/components/components.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormFaild(
                  controller: searchController,
                  label: 'Search',
                  prefix: Icons.search,
                  type: TextInputType.text,
                  validated: (String? value) {
                    if (value!.isEmpty) {
                      return 'search must not Empty';
                    }
                    return null;
                  },
                  onChanged: (String value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  onSubmitted: (String value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                  onTap: () {},
                ),
              ),
              Expanded(child: articalBuilder(list, context, isSearch: true)),
            ],
          ),
        );
      },
    );
  }
}
