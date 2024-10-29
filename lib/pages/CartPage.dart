import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Expanded(
            child: cubit.Carts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/empty.png",
                          height: 100,
                          width: 100,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'There is No Carts',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            GridView.builder(
                                itemCount: cubit.Carts.length,
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
                                    model: cubit.Carts[index],
                                    cubit: cubit,
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xff224773),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "TotalPrice : ${cubit.totalPrice}",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          );
        });
  }
}
