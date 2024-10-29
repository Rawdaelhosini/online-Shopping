import 'dart:convert';

import 'package:api/Modules/Screens/auth_cubit/auth_State.dart';
import 'package:api/Shared/constants/constants.dart';
import 'package:api/Shared/network/local_network.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit(): super(AuthInitialState());


  // Method for register
  void register({required String name, required String email, required String phone,required String password})async {
    emit(RegisterLoadingState());
   Response response =  await http.post(
      Uri.parse("https://student.valuxapps.com/api/register"),
      headers: {
        'lang':'en'
      },
      body: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      }
    );
    //عشان افك التشفير
    var responseBody = jsonDecode(response.body);
    if(responseBody['status'] == true){
      // emit success
      print(responseBody);
      emit(RegisterSuccessState());
    }else {
      //failed
      print(responseBody);
      emit(FailedRegisterState(message: responseBody['message']));   //عشان يطلعلي رساله لو في حاجه غلط
    }

  }





//Method for Login
void login({required String email,required String password})async{
  emit(LoginLoadingState());
  try {                     //عشان ممكن يحصل هنا اي مشكله هحط try/catch
    Response response=  await http.post(
   Uri.parse("https://student.valuxapps.com/api/login"),
    headers: {
        'lang':'en'
      },
      body: {
        'email': email,
        'password': password,
      },

  );
  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    if (responseData['status'] == true) {
      // debugPrint('User login success and his Data is : ${responseData['data']['token']}');

      
     await CacheNetwork.insertToCache(key: "token", value: responseData['data']['token']);    //for save token
     await CacheNetwork.insertToCache(key: "password", value: password);
     userToken  =await CacheNetwork.getCacheData(key: "token");
     currentPassword =await CacheNetwork.getCacheData(key: "password");
     print("User token is : $userToken");
     print("User token is : $currentPassword");
      emit(LoginSuccessState());
      
    }
    else{
       debugPrint('Failed to login , reason is  : ${responseData['message']}');
      emit(FailedToLoginState(message: responseData['message']));
    }
  }
  } catch (e) {

    emit(FailedToLoginState(message: e.toString()));
  }

}



}