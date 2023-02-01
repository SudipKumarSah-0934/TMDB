import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/res/colors.dart';
import '../../data/response/status.dart';
import '../../repository/view_model/home_view_model.dart';
import '../../res/app_urls.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  _MenusState createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  int _currentIndex = 0;
  int activeIndex = 1;
  HomeViewModel homeViewModel = HomeViewModel();
  late List<String> images = <String>[];
  @override
  void initState() {
    homeViewModel.fetchMoviesListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            ChangeNotifierProvider<HomeViewModel>(
              create: (BuildContext context) => homeViewModel,
              child: Consumer<HomeViewModel>(builder: (context, value, _) {
                switch (value.moviesList.status) {
                  case Status.Loading:
                    return CircularProgressIndicator();
                  case Status.ERROR:
                    return Text(value.moviesList.message.toString());
                  case Status.Completed:
                    return ListView.builder(
                        itemCount: value.moviesList.data?.results?.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          images.add(AppUrls.imageUrl +
                              value.moviesList.data!.results![index].posterPath
                                  .toString());

                          //print(images.length);
                          return Container();
                        });
                }
                return Container();
              }),
            ),

            /* CarouselSlider(
              items: images.map((imageUrl) {
                return Builder(builder: (BuildContext context) {
                  return Column(
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width/1.5,
                          height: MediaQuery.of(context).size.height/2,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.fill,

                          ),
                        ),
                      ),
                    ],
                  );
                });
              }).toList(),
              options: CarouselOptions(
                onPageChanged: (index,reason){
                  setState(() {
                    activeIndex=index;
                  });
                },
                initialPage: 0,
                autoPlay: false,
                autoPlayInterval: Duration(seconds: 3),
                reverse: false,
              ),
            ),*/
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                pageSnapping: true,
                enlargeCenterPage: true,
                height: MediaQuery.of(context).size.height / 2.5,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      activeIndex = index;
                    },
                  );
                },
              ),
              items: images
                  .map(
                    (item) => Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Card(
                        margin: EdgeInsets.only(
                          top: 10.0,
                          bottom: 10.0,
                        ),
                        elevation: 6.0,
                        shadowColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Image.network(
                                item,
                                fit: BoxFit.fill,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),

                AnimatedSmoothIndicator(
                  activeIndex: activeIndex,
                  count: images.length,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.buttonActiveColor,
                      dotColor: AppColors.buttonRestColor,
                      dotHeight: 15,
                      dotWidth: 15,
                      spacing: 15),
                ),
              ],

        ),
      ),
    );
  }
}
