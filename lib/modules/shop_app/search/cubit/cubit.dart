import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_one/models/shop_app/search_model.dart';
import 'package:test_one/modules/shop_app/search/cubit/states.dart';
import 'package:test_one/shared/component/constants/constants.dart';
import 'package:test_one/shared/network/endpoints.dart';
import 'package:test_one/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;

  void search(String? text) {
    DioHelper.postData(
      url: SEARCH,
      data: {
        'text': text,
      },
      token: token,
    ).then((value){
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
