abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsChangeBottomNavState extends NewsState {}

class NewsGetBusinessSuccessState extends NewsState {}

class NewsLoadingBusinessState extends NewsState {}

class NewsGetBusinessErrorState extends NewsState {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsLoadingSportState extends NewsState {}

class NewsGetSportSuccessState extends NewsState {}

class NewsGetSportErrorsState extends NewsState {
  final String error;

  NewsGetSportErrorsState(this.error);
}

class NewsLoadingScienceState extends NewsState {}

class NewsGetScienceSuccessState extends NewsState {}

class NewsGetScienceErrorsState extends NewsState {
  final String error;

  NewsGetScienceErrorsState(this.error);
}
class NewsLoadingSearchState extends NewsState {}

class NewsGetSearchSuccessState extends NewsState {}

class NewsGetSearchErrorsState extends NewsState {
  final String error;

  NewsGetSearchErrorsState(this.error);
}
