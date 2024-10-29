abstract class LayoutStatus {}
class LayoutInitialState extends LayoutStatus{}

class GetUserDataSuccessState extends LayoutStatus{}
class GetUserDataLoadingState extends LayoutStatus{}
class FailedToGetUserDataState extends LayoutStatus{
  String error;
  FailedToGetUserDataState({required this.error});

}

class changeBottomNavIndexState extends LayoutStatus{}

//for Banners
class getBannersLoadingState extends LayoutStatus{}
class getBannersSuccessState extends LayoutStatus{}
class FailedTogetBannersState extends LayoutStatus{
  String error;
  FailedTogetBannersState({required this.error});

}

//for Visibaility search
class ShopChangeVisibilityState extends LayoutStatus{}
class ShopRotateState extends LayoutStatus{}
class ShopReadMoreState extends LayoutStatus{
}

//for Product
class getProductsSuccessState extends LayoutStatus{}
class FailedTogetProductsState extends LayoutStatus{}

//for Search
class FilterProductsSuccessState extends LayoutStatus{}

//for category
class getcategoriesSuccessState extends LayoutStatus{}
class FailedTogetcategoriesState extends LayoutStatus{}

//for favorite
class getFavoritesSuccessState extends LayoutStatus{}
class FailedTogetFavoritesState extends LayoutStatus{}


//get addOrRemoveFromFavorite
class AddOrRemoveFromFavoriteSuccessState extends LayoutStatus{}
class FailedToAddOrRemoveFromFavoriteState extends LayoutStatus{}

//for favorite
class getCartsSuccessState extends LayoutStatus{}
class FailedTogetCartssState extends LayoutStatus{}

//get addOrRemoveFromCarts
class AddOrRemoveFromCartsSuccessState extends LayoutStatus{}
class FailedToAddOrRemoveFromCartsState extends LayoutStatus{}

//for change password
class getChangePasswordLoadingState extends LayoutStatus{}
class getChangePasswordSuccessState extends LayoutStatus{}
class FailedTogetChangePasswordState extends LayoutStatus{
  String error;
  FailedTogetChangePasswordState(this.error);
}


//for Update User Data
class UpdateUserDataLoadingState extends LayoutStatus{}
class UpdateUserDataSuccessState extends LayoutStatus{}
class FailedTogetUpdateUserDataState extends LayoutStatus{
  String error;
  FailedTogetUpdateUserDataState(this.error);
}


//for LOGOUT
class LogoutLoading extends LayoutStatus {}
class LogoutSuccess extends LayoutStatus {}
class LogoutFailure extends LayoutStatus {
  final String error;
  LogoutFailure(this.error);
}

//For ProductDetails
class GetProductDetailsSuccessState extends LayoutStatus{}
class GetProductDetailsLoadingState extends LayoutStatus{}
class FailedToGetProductDetailsState extends LayoutStatus{
  String error;
  FailedToGetProductDetailsState({required this.error});

}

//for categoryDetails
class getLoadingCategoriesDetailsState extends LayoutStatus{}
class getSuccessCategoriesDetailsState extends LayoutStatus{}
class getFailedCategoriesDetailsState extends LayoutStatus{

}

//for category
class getLoadingCategoriesState extends LayoutStatus{}
class getSuccessCategoriesState extends LayoutStatus{}
class getFailedCategoriesState extends LayoutStatus{

}





