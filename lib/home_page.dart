import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_task/models.dart';

import 'constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orientation =MediaQuery.of(context).orientation;
    bool isPortrait=orientation == Orientation.portrait;
    double screenHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.account_circle_sharp,
          color: Colors.black,
        ),
        actions: const [
          Icon(
            Icons.login_rounded,
            color: Colors.black,
          ),
          SizedBox(
            width: 6,
          ),
        ],
        title: const Text(
          'الرئيسية',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            carouselSliderBuilder(context,isPortrait?screenHeight/3.5:screenHeight/1.85),
            Wrap(
              spacing: 8, //vertical spacing
              runSpacing: 8, //horizontal spacing
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children:categoryItems.map((e) =>categoryItemBuilder(context, e)).toList()
            ),
          ],
        ),
      ),
    );
  }


  Widget categoryItemBuilder(BuildContext context, CategoryModel model) =>
      Container(
        height: 150,
        width: 150,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
        shape: BoxShape.circle,
            // borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: const Offset(1, 3),
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(model.icon),
              fit: BoxFit.cover,
              height: 80,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              model.text,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 21),
            )
          ],
        ),
      );

  Widget carouselSliderBuilder(BuildContext context,double height) => CarouselSlider(
        options: CarouselOptions(
          // scrollPhysics: NeverScrollableScrollPhysics(),
          height: height,
          viewportFraction: 0.82,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal
        ),
        items: sliderItems
            .map((item) => sliderItemBuilder(context, item,height))
            .toList(),
      );

  Widget sliderItemBuilder(BuildContext context, String image,double height) => Center(
        child: Container(
          height: height-50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.fill,
            ),
          ),
        ),
      );
}
