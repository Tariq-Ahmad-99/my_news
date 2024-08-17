import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/search/search_screen.dart';
import '../shared/components/components.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class NewsLayout extends StatelessWidget
{
  const NewsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                'News App',
              ),
              actions: [
                IconButton(
                    onPressed: ()
                    {
                      navigateTo(context, SearchScreen());
                    },
                    icon: const Icon(
                      Icons.search,
                    ),
                ),
                IconButton(
                    onPressed: ()
                    {
                      cubit.changeAppMode();
                      //NewsCubit.get(context).changeAppMode();
                    },
                    icon: Icon(
                      cubit.isDark ? Icons.light_mode : Icons.dark_mode,//extra
                      //Icons.dark_mode,
                    ),
                ),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,//extra
          );
        },
    );
  }
}