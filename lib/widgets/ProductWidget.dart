import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductWidget extends StatelessWidget {
  dynamic model;
  final bool isSearch;
  LayoutCubit cubit;
  ProductWidget(
      {required this.model,
      required this.cubit,
      this.isSearch = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(17.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      if (model.discount != 0 && isSearch == false)
                        Container(
                          height: 25,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(70),
                              bottomRight: Radius.circular(70),
                            ),
                            color: Color(0xff224773),
                          ),
                          child: Center(
                            child: Text(
                              "${model.discount!}\%",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 100, // Set your desired width
                    height: 100,
                    child: FadeInImage(
                      placeholder: const AssetImage(
                        "assets/empty.png",
                      ),
                      image: NetworkImage(
                        model.image!,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    model.name!,
                    style: TextStyle(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            if (model.discount != 0 && isSearch == false)
                              Text(
                                "${model.oldPrice!}\$",
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 13,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Colors.grey[400],
                                ),
                              ),
                            Spacer(),
                            Text(
                              "${model.price!}\$",
                              style: TextStyle(
                                color: Color(0xff224773),
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Icon(
                          Icons.favorite,
                          size: 20,
                          color: cubit.favoritesID.contains(model.id.toString())
                              ? Colors.red
                              : Colors.grey,
                        ),
                        onTap: () {
                          //ADD | REMOVE FAVORITES
                          cubit.addOrRemoveFromeFavorite(
                              productID: model.id.toString());
                        },
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        cubit.addOrRemoveFromCarts(id: model.id.toString());
                      },
                      child: Container(
                        height: 25,
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                          color: cubit.CartsID.contains(model.id.toString())
                              ? Colors.green
                              : Color(0xff224773),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
