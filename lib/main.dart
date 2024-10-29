import 'package:api/Auth/login.dart';
import 'package:api/Modules/Screens/auth_cubit/auth_Cubit.dart';
import 'package:api/Shared/constants/constants.dart';
import 'package:api/Shared/network/local_network.dart';
import 'package:api/helper/diohelper.dart';
import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_screen.dart';
import 'package:api/onboardring/boardring1.dart';
import 'package:api/onboardring/onboardring2.dart';
import 'package:api/onboardring/onboardring3.dart';
import 'package:api/pages/SplachScreen.dart';
import 'package:api/pages/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheNetwork.cacheInitialization();
  userToken = await CacheNetwork.getCacheData(key: 'token');
  currentPassword = await CacheNetwork.getCacheData(key: 'password');
  print('user token is : $userToken');
  print('currentPassword : $currentPassword');
  DioHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(
          create: (context) => LayoutCubit()
            ..getBannersData()
            ..getUserData()
            ..getProducts()
            ..getFavorites()
            ..getCarts()
            ..getProductDetails()
            ..getCategoriesDetailsData(43)
            ..getCategoriesDataa(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          onboardring.id: (context) => const onboardring(),
          onboardring2.id: (context) => const onboardring2(),
          onboardring3.id: (context) => const onboardring3(),
          LoginPage.id: (context) => const LoginPage(),
          LayoutScreen.id: (context) => const LayoutScreen(),
          Profile.id: (context) => Profile(),
        },
        home: userToken != null && userToken != ""
            ? const LayoutScreen()
            : const Splachscreen(),
      ),
    );
  }
}
