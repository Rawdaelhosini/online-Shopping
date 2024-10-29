import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return 
          
          Expanded(
            
            child: 
            cubit.favorites.isEmpty?
            Center(
                    child: Column(
                       mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        Image.asset(
                          "assets/empty.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(height: 20,),
                        Text('There is No favorites',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ):
            GridView.builder(
                      itemCount: cubit.favorites.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 210,
                        childAspectRatio: 0.63,
                        crossAxisSpacing: 0.6,
                        mainAxisSpacing: 0.6,
                      ),
                      itemBuilder: (context, index) {
                        return ProductWidget(
                          model: cubit.favorites[index] ,
                          cubit: cubit,
                        );
            
                       
                      }),
          
        );
      }
      );

  }
}