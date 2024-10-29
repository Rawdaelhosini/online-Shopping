import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/pages/Home.dart';
import 'package:api/widgets/Detailes/productDetailes.dart';
import 'package:api/widgets/ProductWidget.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class Categorydetails extends StatelessWidget {
  final String title;
  const Categorydetails({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          var model = cubit.categoriesDetailsModel?.data.products;
          print("product ${cubit.categoriesDetailsModel?.data.products}");
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: ConditionalBuilder(
              condition: state is! getLoadingCategoriesDetailsState,
              builder: (context) => GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 210,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 2,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: model!.length,
                  itemBuilder: (ctx, index) {
                    return GestureDetector(
                        onTap: () {
                          animatedNavigateTo(
                            context: ctx,
                            widget: Productdetailes(
                                model: model[index], cubit: cubit),
                            direction: PageTransitionType.leftToRight,
                            curve: Curves.easeInExpo,
                          );
                        },
                        child: ProductWidget(
                          model: model[index],
                          cubit: cubit,
                        ));
                  }),
              fallback: (context) => Center(
                  child: Image.asset(
                "assets/loading-cargando.gif",
                height: 95,
                width: 95,
              )),
            ),
          );
        });
  }
}
