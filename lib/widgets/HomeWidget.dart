import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/Detailes/productDetailes.dart';
import 'package:api/widgets/ProductWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class Homewidget extends StatelessWidget {
  const Homewidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          return Expanded(
            child: cubit.products.isEmpty
                ? Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Center(
                      child: Image.asset(
                        "assets/loading-cargando.gif",
                        height: 100,
                        width: 100,
                      ),
                    ),
                )
                : GridView.builder(
                    itemCount: cubit.products.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 210,
                      childAspectRatio: 0.63,
                      crossAxisSpacing: 0.6,
                      mainAxisSpacing: 0.6,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          animatedNavigateTo(
                        context: context,
                        widget: Productdetailes(
                          model: cubit.products[index],
                          cubit: cubit,
                         
                        ),
                        direction: PageTransitionType.leftToRight,
                        curve: Curves.easeInExpo,
                      );
                    },
                        
                        child: ProductWidget(
                          cubit: cubit,
                          model: cubit.products[index],
                        ),
                      );

                     
                    }),
          );
        });
  }
}

void animatedNavigateTo({
  required BuildContext context,
  required Widget widget,
  required PageTransitionType direction,
  Curve curve = Curves.linear,
}) {
  Navigator.push(
    context,
    PageTransition(
      type: direction,
      child: widget,
      curve: curve,
      duration: Duration(milliseconds: 500), // Adjust duration as needed
    ),
  );
}
