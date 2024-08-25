import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_news/shared/cubit/states.dart';
import '../../modules/business/business_screen.dart';
import '../../modules/science/science_screen.dart';
import '../../modules/sports/sports_screen.dart';
import '../network/local/cache_helper.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems =
  [
    const BottomNavigationBarItem(
        icon: Icon(
            Icons.business,
        ),
        label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports_baseball,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'science',
    ),
  ];

  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    if(index == 1) {
      getSports();
    }
    if(index == 2) {
      getScience();
    }
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  int selectedBusinessItem = 0;
  bool isDesktop = false;

  void setDesktop(bool value)
  {
    isDesktop = value;
    emit(NewSetDesktopState());
  }

  void getBusiness()
  {
    emit(NewsGetBusineessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country':'us',
        'category':'business',
        'apiKey':'a844df189f64488a8fb4479710aa4c60',
      },
    ).then((value)
    {
      business = value.data['articles'];
      // businessSelectedItem.forEach((elemet)
      // {
      //   businessSelectedItem.add(false);
      // });
      emit(NewGetBusineessSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewGetBusineessErrorState(error.toString()));
    });
  }

  void selectBusinessItem(index){
    selectedBusinessItem = index;
    emit(NewSelectBusineessItemState());
  }

  List<dynamic> sports = [];
  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    if(sports.isEmpty)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'sports',
          'apiKey':'a844df189f64488a8fb4479710aa4c60',
        },
      ).then((value)
      {
        sports = value.data['articles'];
        emit(NewGetSportsSuccessState());
      }).catchError((error){
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewGetSportsErrorState(error.toString()));
      });
    } else
      {
        emit(NewGetSportsSuccessState());
      }
  }

  List<dynamic> science = [];
  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    if(science.isEmpty)
    {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'us',
          'category':'science',
          'apiKey':'a844df189f64488a8fb4479710aa4c60',
        },
      ).then((value)
      {
        science = value.data['articles'];
        emit(NewGetScienceSuccessState());
      }).catchError((error){
        if (kDebugMode) {
          print(error.toString());
        }
        emit(NewGetScienceErrorState(error.toString()));
      });
    } else
      {
        emit(NewGetScienceSuccessState());
      }
  }

  bool isDark = false;
  void changeAppMode({bool? fromShared})
  {
    if(fromShared != null)
    {
      isDark = fromShared;
      emit(NewsChangeModeState());
    }
    else
    {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value)
      {
        emit(NewsChangeModeState());
      });
    }
  }


  List<dynamic> search = [];
  void getSearch(String value)
  {
    emit(NewsGetScienceLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q' : value,
        'apiKey':'a844df189f64488a8fb4479710aa4c60',
      },
    ).then((value)
    {
      search = value.data['articles'];
      emit(NewGetSearchSuccessState());
    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewGetSearchErrorState(error.toString()));
    });
  }

}


