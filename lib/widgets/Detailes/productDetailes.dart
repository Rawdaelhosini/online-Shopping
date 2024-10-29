import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Productdetailes extends StatelessWidget {
  dynamic model;
  final bool isSearch;
  LayoutCubit cubit;
  //required this.model, this.isFav, this.isSearch = false,
  Productdetailes(
      {required this.model,
      required this.cubit,
      this.isSearch = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text(
                "Online Shopping",
                style: TextStyle(
                    color: Color(0xff224773), fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.name!,
                      style: TextStyle(fontSize: 24, color: Color(0xff224773)),
                    ),
                    Row(
                      children: [
                        Text(
                          "${model.price!}\$",
                          style:
                              TextStyle(fontSize: 24, color: Color(0xff224773)),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        if (model.discount != 0 && isSearch == false)
                          Text(
                            "${model.oldPrice!}\$",
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.grey[400],
                                color: Colors.grey),
                          ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        height: 272,
                        width: 220,
                        child: FadeInImage(
                          placeholder:
                              const AssetImage("assets/images/sign.jpg"),
                          image: NetworkImage(
                            model.image!,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                          model.images.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: SizedBox(
                              height: 90,
                              width: 90,
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage("assets/empty.png"),
                                image: NetworkImage(
                                  model.images[index],
                                ),
                                //   model.images != null &&
                                //             model.images!.isNotEmpty
                                //         ? model.images![0]
                                //         : "fallback_image_url" // Provide a fallback image URL
                                //     ),
                                // fit: BoxFit.fill, // Optional: to cover the box
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.description!,
                          maxLines: cubit.flag ? 3 : null,
                          overflow: cubit.flag ? TextOverflow.ellipsis : null,
                          style: TextStyle(color: Colors.grey),
                        ),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                cubit.flag ? "Show More.." : "Show Less",
                                style: TextStyle(color: Color(0xff224773)),
                              ),
                            ],
                          ),
                          onTap: () {
                            cubit.readMore();
                          },
                        ),
                        const SizedBox(
                          height: 58,
                        ),
                        Row(
                          children: [
                            // Icon(Icons.favorite),
                            // if (isFav != null)
                            GestureDetector(
                              child: Icon(
                                Icons.favorite,
                                size: 20,
                                color: cubit.favoritesID
                                        .contains(model.id.toString())
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              onTap: () {
                                //ADD | REMOVE FAVORITES
                                cubit.addOrRemoveFromeFavorite(
                                    productID: model.id.toString());
                              },
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 200,
                              height: 50,
                              child: ElevatedButton(
                                  onPressed: () {
                                    cubit.addOrRemoveFromCarts(
                                        id: model.id.toString());
                                  },
                                  style: ButtonStyle(
                                    foregroundColor:
                                        WidgetStateProperty.all(Colors.white),
                                    shape: WidgetStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                    ),
                                    backgroundColor: WidgetStateProperty.all(
                                        Color(0xff224773)),
                                  ),
                                  child: Text("Add To Cart")),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
