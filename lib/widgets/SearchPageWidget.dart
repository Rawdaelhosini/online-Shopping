import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Searchpagewidget extends StatelessWidget {
  const Searchpagewidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return   Scaffold(
      appBar: AppBar(
        title: Center(
            child: const Text(
          "Search",
          style: TextStyle(
              color: Color(0xff224773),
              fontWeight: FontWeight.bold,
              fontSize: 30),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: (input) {
                cubit.filterProducts(input: input);
                
              },
              cursorColor: Color(0xff224773),
              decoration: InputDecoration(
                hintText: 'What do you want to search for?',
                hintStyle: TextStyle(color: Colors.grey[400]),
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                ),
                filled: true,
                fillColor: const Color.fromARGB(16, 0, 0, 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xff224773),
                      width: 2,
                    )),
              ),
            ),
          
            Expanded(
            child: GridView.builder(
              
                padding: const EdgeInsets.symmetric(horizontal: 5),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 210,
                  childAspectRatio: 0.6,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: cubit.filteredProducts.length,
                itemBuilder: (ctx, index) {
                  return ProductWidget(
                        model: cubit.filteredProducts[index],
                        cubit: cubit,
                      );
                }),
          ),
          ],
        ),
      
      ),
    );
  
      });
    
  
  
  }
}
