import 'package:api/layout/layout_cubit/layout_cubit.dart';
import 'package:api/layout/layout_cubit/layout_status.dart';
import 'package:api/widgets/BottomCategoryWidget.dart';
import 'package:api/widgets/HomeWidget.dart';
import 'package:api/widgets/SearchPageWidget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit, LayoutStatus>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            body: ListView(
          children: [
            cubit.userModel != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Text(
                        "Hello,${cubit.userModel!.name!}",
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xff224773),
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AnimatedOpacity(
                            opacity: (cubit.visible == true ? 0 : 1),
                            duration: const Duration(seconds: 2),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      
                                      animatedNavigateTo(
                                        context: context,
                                        widget: const Searchpagewidget(),
                                        direction: PageTransitionType.bottomToTop,
                                        curve: Curves.linear,
                                      );
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff224773),
                                      radius: 16,
                                      child: const Center(
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          backgroundColor: Colors.grey[300],
                                          context: context,
                                          builder: (context) {
                                            return const Bottomcategorywidget();
                                           
                                          });
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff224773),
                                      radius: 16,
                                      child: const Center(
                                        child: Icon(
                                          Icons.category_outlined,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              cubit.changeVisibility();
                              cubit.rotate();
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TweenAnimationBuilder<double>(
                                curve: Curves.easeInCubic,
                                duration: const Duration(seconds: 1),
                                tween: Tween(begin: 0, end: cubit.angle),
                                builder: (_, angle, child) => Transform.rotate(
                                  angle: angle,
                                  child: child,
                                ),
                                child: CircleAvatar(
                                  backgroundColor: Color(0xff224773),
                                  radius: 16,
                                  child: const Center(
                                    child: Icon(
                                      Icons.more_vert,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
                  )
                : Text(''),
            cubit.banners.isEmpty
                ?  Text('')
               
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 125,
                      width: double.infinity,
                      child: CarouselSlider.builder(
                        itemCount: cubit.banners.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              // Add any other decoration you need
                            ),
                            margin: EdgeInsets.only(right: 12.5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  30), // Ensure rounded corners
                              child: Image.network(
                                cubit.banners[index].url!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  ),
                  Homewidget(),
         
          ],
        ));
      },
    );
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


