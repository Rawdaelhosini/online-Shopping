import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/Detailes/CategoryDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class Bottomcategorywidget extends StatelessWidget {
  const Bottomcategorywidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit, LayoutStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LayoutCubit.get(context);
          var model = cubit.categoriesModel?.data.dataModel;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: model!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    cubit.getCategoriesDetailsData(model[index].id);
                    animatedNavigateTo(
                      context: context,
                      widget: Categorydetails(
                        title: model[index].name,
                      ),
                      direction: PageTransitionType.rightToLeft,
                      curve: Curves.bounceIn,
                    );
                  },
                  child: Card(
                    // shadowColor: lightPurple,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 87,
                            width: 137,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(30)),
                              child: FadeInImage(
                                placeholder:
                                    const AssetImage("assets/empty.png"),
                                image: NetworkImage(model[index].image),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset("assets/empty.png");
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            model[index].name,
                            style: TextStyle(
                                color: Color(0xff224773),
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff224773),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
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
