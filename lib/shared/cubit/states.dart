abstract class NewsStates {}

class NewsInitialState extends NewsStates {}
class NewsBottomNavState extends NewsStates {}

class NewsGetBusineessLoadingState extends NewsStates{}
class NewGetBusineessSuccessState extends NewsStates{}
class NewGetBusineessErrorState extends NewsStates
{
  final String error;
  NewGetBusineessErrorState(this.error);
}

class NewSelectBusineessItemState extends NewsStates{}
class NewSetDesktopState extends NewsStates{}


class NewsGetSportsLoadingState extends NewsStates{}
class NewGetSportsSuccessState extends NewsStates{}
class NewGetSportsErrorState extends NewsStates
{
  final String error;
  NewGetSportsErrorState(this.error);
}


class NewsGetScienceLoadingState extends NewsStates{}
class NewGetScienceSuccessState extends NewsStates{}
class NewGetScienceErrorState extends NewsStates
{
  final String error;
  NewGetScienceErrorState(this.error);
}

class NewsChangeModeState extends NewsStates{}



class NewsGetSearchLoadingState extends NewsStates{}
class NewGetSearchSuccessState extends NewsStates{}
class NewGetSearchErrorState extends NewsStates
{
  final String error;
  NewGetSearchErrorState(this.error);
}

