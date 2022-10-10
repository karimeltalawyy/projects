import '../../../../models/shop_app/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginSuccsessState extends ShopLoginStates {
  final ShopLoginModel loginModel;
  ShopLoginSuccsessState(this.loginModel);
}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginChangePasswordVisibilityState extends ShopLoginStates {}

class ShopLoginErrorState extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);
}
