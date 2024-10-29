import 'dart:convert';
import 'package:api/Models/Product_model.dart';
import 'package:api/Models/User_model.dart';
import 'package:api/Models/banner_model.dart';
import 'package:api/Models/catdetails.dart';
import 'package:api/Models/category_model.dart';
import 'package:api/Models/product_details.dart';
import 'package:api/Shared/constants/constants.dart';
import 'package:api/Shared/network/local_network.dart';
import 'package:api/helper/diohelper.dart';
import 'package:api/helper/endpoint.dart';

import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/pages/CartPage.dart';
import 'package:api/pages/FavoritesPage.dart';
import 'package:api/pages/Home.dart';
import 'package:api/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutStatus> {
  LayoutCubit() : super(LayoutInitialState());
  static LayoutCubit get(context) => BlocProvider.of(context);

  //for Navigator bar
  int bottomNavIndex = 0;
  List<Widget> layoutScreens = [
    const HomePage(),
    const FavoritesPage(),
    const CartPage(),
    const Profile(),
  ];
  void changeBottomNavIndex({required int index}) {
    bottomNavIndex = index;
    //emit state
    emit(changeBottomNavIndexState());
  }

  //for Banner
  List<BannerModel> banners = [];
  void getBannersData() async {
    emit(getBannersLoadingState());
    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/banners"), headers: {
      'Authorization': userToken!,
      'lang': 'en',
    });
    final responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']) {
        banners.add(BannerModel.fromjson(data: item));
      }
      emit(getBannersSuccessState());
    } else {
      emit(FailedTogetBannersState(error: responseBody['message']));
    }
  }

// for visibale search
  bool visible = true;
  void changeVisibility() {
    visible = !visible;
    emit(ShopChangeVisibilityState());
  }

  bool isTapped = false;
  double angle = 0;
  void rotate() {
    isTapped = !isTapped;
    angle = isTapped ? 4.71238898038469 : 0;
    emit(ShopRotateState());
  }

  bool flag = true;
  void readMore() {
    flag = !flag;
    emit(ShopReadMoreState());
  }

  //for get data Auth
  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/profile"), headers: {
      'Authorization': userToken!,
      'lang': 'en',
    });
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      userModel = UserModel.fromJson(data: responseData['data']);
      print('response : $responseData');
      emit(GetUserDataSuccessState());
    } else {
      emit(FailedToGetUserDataState(error: responseData['message']));
    }
  }

// For Product
  List<ProductModel> products = [];
  void getProducts() async {
    emit(GetUserDataLoadingState());
    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/home"), headers: {
      'Authorization': userToken!,
      'lang': 'en',
    });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        products.add(ProductModel.fromJson(data: item));
      }
      emit(getProductsSuccessState());
    } else {
      emit(FailedTogetProductsState());
    }
  }

  List<ProductDetails> details = [];
  void getProductDetails() async {
    emit(GetUserDataLoadingState());
    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/home"), headers: {
      'Authorization': userToken!,
      'lang': 'en',
    });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['products']) {
        details.add(ProductDetails.fromjson(data: item));
      }
      emit(getProductsSuccessState());
    } else {
      emit(FailedTogetProductsState());
    }
  }

//For Search
  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input}) {
    filteredProducts = products
        .where((element) =>
            element.name!.toLowerCase().startsWith(input.toLowerCase()))
        .toList();
    emit(FilterProductsSuccessState());
  }

// //for category
// List<CategoryModel> categories=[];
// void getCategoriesData() async {

//     Response response = await http
//         .get(Uri.parse("https://student.valuxapps.com/api/categories"), headers: {

//       'lang': 'en',
//     });
//     final responseBody = jsonDecode(response.body);
//     if (responseBody['status'] == true) {
//       for (var item in responseBody['data']['data']) {
//         categories.add(CategoryModel.fromJson(data: item));
//       }
//       emit(getcategoriesSuccessState());
//     } else {
//       emit(FailedTogetcategoriesState());
//     }
//   }

//get Favorite
  List<ProductModel> favorites = [];
//set مفيش تكرار
  Set<String> favoritesID = {};
  Future<void> getFavorites() async {
    favorites.clear();
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers: {
          'Authorization': userToken!,
          'lang': 'en',
        });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['data']) {
        //refactoring for data in API
        favorites.add(ProductModel.fromJson(data: item['product']));
        favoritesID.add(item['product']['id'].toString());
      }
      print("favorites number is: ${favorites.length}");
      emit(getFavoritesSuccessState());
    } else {
      emit(FailedTogetFavoritesState());
    }
  }

//get addOrRemoveFromeFavorite
  void addOrRemoveFromeFavorite({required String productID}) async {
    Response response = await http.post(
        Uri.parse("https://student.valuxapps.com/api/favorites"),
        headers: {
          'Authorization': userToken!,
          'lang': 'en',
        },
        body: {
          "product_id": productID
        });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (favoritesID.contains(productID) == true) {
        //delete for set
        favoritesID.remove(productID);
      } else {
        //add in set
        favoritesID.add(productID);
      }
      await getFavorites();
      emit(AddOrRemoveFromFavoriteSuccessState());
    } else {
      emit(FailedToAddOrRemoveFromFavoriteState());
    }
  }

//get Carts
  List<ProductModel> Carts = [];
  int totalPrice = 0;
//set مفيش تكرار
  Set<String> CartsID = {};
  Future<void> getCarts() async {
    Carts.clear();

    Response response = await http
        .get(Uri.parse("https://student.valuxapps.com/api/carts"), headers: {
      'Authorization': userToken!,
      'lang': 'en',
    });
    var responseBody = jsonDecode(response.body);
    totalPrice = responseBody['data']['total'].toInt();
    if (responseBody['status'] == true) {
      for (var item in responseBody['data']['cart_items']) {
        //refactoring for data in API
        Carts.add(ProductModel.fromJson(data: item['product']));
        CartsID.add(item['product']['id'].toString());
      }
      print("Carts number is: ${Carts.length}");
      emit(getCartsSuccessState());
    } else {
      emit(FailedTogetCartssState());
    }
  }

//get addOrRemoveFromCarts
  void addOrRemoveFromCarts({required String id}) async {
    Response response = await http
        .post(Uri.parse("https://student.valuxapps.com/api/carts"), headers: {
      'Authorization': userToken!,
      'lang': 'en',
    }, body: {
      "product_id": id
    });
    var responseBody = jsonDecode(response.body);
    if (responseBody['status'] == true) {
      if (CartsID.contains(id) == true) {
        //delete for set
        CartsID.remove(id);
      } else {
        //add in set
        CartsID.add(id);
      }
      await getCarts();
      emit(AddOrRemoveFromCartsSuccessState());
    } else {
      emit(FailedToAddOrRemoveFromCartsState());
    }
  }

//change password
  void changePassword(
      {required String userCurrentPassword,
      required String newPassword}) async {
    emit(getChangePasswordLoadingState());
    Response response = await http.post(
        Uri.parse('https://student.valuxapps.com/api/change-password'),
        headers: {
          'lang': 'en',
          // 'Content-Type': 'application/json',
          'Authorization': userToken!,
        },
        body: {
          'current_password': userCurrentPassword,
          'new_password': newPassword,
        });
    var responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (responseBody['status'] == true) {
        await CacheNetwork.insertToCache(key: 'password', value: newPassword);
        currentPassword = await CacheNetwork.getCacheData(key: "password");

        emit(getChangePasswordSuccessState());
      } else {
        emit(FailedTogetChangePasswordState(responseBody['message']));
      }
    } else
      (emit(FailedTogetChangePasswordState(
          'Something weent Wrong , try again later')));
  }

//Update User Data
  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) async {
    emit(UpdateUserDataLoadingState());
    try {
      Response response = await http.put(
          Uri.parse('https://student.valuxapps.com/api/update-profile'),
          headers: {
            'lang': 'en',
            'Authorization': userToken!,
          },
          body: {
            'name': name,
            'email': email,
            'phone': phone,
          });
      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        await getUserData();
        emit(UpdateUserDataSuccessState());
      } else {
        emit(FailedTogetUpdateUserDataState(responseBody['message']));
      }
    } catch (e) {
      emit(FailedTogetUpdateUserDataState(e.toString()));
    }
  }

//for logout
  void logout() async {
    emit(LogoutLoading());
    try {
      final response = await http.post(
          Uri.parse('https://student.valuxapps.com/api/logout'),
          headers: {
            'lang': 'en',
            'Authorization': userToken!,
            // 'Content-Type': 'application/json',
          },
          body: {
            "fcm_token": "SomeFcmToken"
          });

      var responseBody = jsonDecode(response.body);

      if (responseBody['status'] == true) {
        emit(LogoutSuccess());
      } else {
        emit(LogoutFailure(responseBody['message'] ?? 'Logout failed'));
      }
    } catch (e) {
      emit(LogoutFailure(e.toString()));
    }
  }

//for category
  CategoriesModel? categoriesModel;
  void getCategoriesDataa() {
    emit(getLoadingCategoriesState());
    DioHelper.getData(url: CATEGORIES, token: userToken).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      // print(categoriesModel?.data.dataModel);
      emit(getSuccessCategoriesState());
    }).catchError((error) {
      print(error);
      emit(getFailedCategoriesState());
    });
  }

  //for category Details
  GetCatDetailsModel? categoriesDetailsModel;
  void getCategoriesDetailsData(int id) {
    emit(getLoadingCategoriesDetailsState());
    DioHelper.getData(url: "$CATEGORIES/$id", token: token).then((value) {
      categoriesDetailsModel = GetCatDetailsModel.fromJson(value.data);
      // print(categoriesModel?.data.dataModel);
      emit(getSuccessCategoriesDetailsState());
    }).catchError((error) {
      print(error);
      emit(getFailedCategoriesDetailsState());
    });
  }
}
