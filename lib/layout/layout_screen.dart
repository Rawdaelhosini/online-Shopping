import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});
  static String id = 'LayoutScreen';

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {

  final List<IconData> _icons = [
    Icons.home_outlined,
    Icons.favorite_border,
    Icons.shopping_cart_outlined,
    Icons.person_outline_outlined,
  ];


  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
           appBar: AppBar(
             
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child:  SvgPicture.asset(
                  "assets/drawer.svg",
                  height: 18,
                  width: 25,
                  color: Color(0xff224773),
                
                ),
              ),
              title: Center(child: Text('Online Shopping',style: TextStyle(color: Color(0xff224773), fontWeight: FontWeight.bold),)),
            ),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
         
          
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: BottomAppBar(
                padding: const EdgeInsets.all(8),
                clipBehavior: Clip.hardEdge,
                shape: const CircularNotchedRectangle(),
                notchMargin: 8,
                child: BottomNavigationBar(
                  selectedItemColor: Color(0xff224773),
                  unselectedItemColor: Colors.grey[700],
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: cubit.bottomNavIndex,
                  onTap: (index) {
                    cubit.changeBottomNavIndex(index: index);
                  },
                  elevation: 0,
                  items: [
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        _icons[0],
                        size: 26,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        _icons[1],
                        size: 26,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        _icons[2],
                        size: 26,
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Colors.transparent,
                      icon: Icon(
                        _icons[3],
                        size: 26,
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
