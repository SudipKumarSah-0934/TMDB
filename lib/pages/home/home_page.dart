import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:tmdb_app/res/colors.dart';
import '../../data/response/status.dart';
import '../../repository/view_model/home_view_model.dart';
import '../../res/app_urls.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../themes/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Brightness? _brightness;
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _brightness == Brightness.dark
          ? AppTheme.darkTheme
          : AppTheme.lightTheme,
      home: Scaffold(
        resizeToAvoidBottomInset:false,
        backgroundColor: Color(0xff05103A),
        body: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenHeight * 0.2,
              margin: EdgeInsets.only(
                top: 30.0,
                left: 10.0,
                right: 10.0,
              ),
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'lib/res/images/img.png',
                        width: 48,
                        height: 48,
                        alignment: Alignment.centerLeft,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                fontSize: 20.0,
                                color: Colors.white70,
                              ),
                              children: const <TextSpan>[
                                TextSpan(text: 'Hello'),
                                TextSpan(
                                  text: ' Arie',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Book your favorite movie',
                            style:
                            TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Image.asset(
                          'lib/res/images/img_1.png',
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search movie..',
                        hintStyle: TextStyle(color: Colors.white70),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'lib/res/images/img_2.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Image.asset(
                            'lib/res/images/img_3.png',
                            width: 16,
                            height: 16,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height:screenHeight*0.05,
              width: double.infinity,
              padding: EdgeInsets.only( top: 5.0,
                left: 10.0,
                right: 10.0,),
              margin: EdgeInsets.only(
                left: 10.0,
                right: 10.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.white70,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'Now',style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),),
                        TextSpan(
                          text: ' Showing',

                        ),
                      ],
                    ),
                  ),
                  Text('See more',style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white24,
                  ),),
                ],
              ),
            ),
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
                return Container(
                );
              }),
            ),
            Expanded(
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  pageSnapping: true,
                  enlargeCenterPage: true,
                    height:screenHeight*.9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
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
                    padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                    child: Card(
                      elevation: 6.0,
                      shadowColor: Colors.black,
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
                              width: double.infinity,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
            AnimatedSmoothIndicator(
              activeIndex: activeIndex,
              count: images.length,
              axisDirection: Axis.horizontal,

              effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.buttonActiveColor,
                  dotColor: Color.fromRGBO(76, 205, 235, 0.3),
                  dotHeight: 15,
                  dotWidth: 15,
                  spacing: 15),
            ),
            Container(
              width: double.infinity,
              height:screenHeight*0.04,
              padding: EdgeInsets.only( top: 10.0,
                left: 10.0,
                right: 10.0,),
              margin: EdgeInsets.only( top: 5.0,
                left: 10.0,
                right: 10.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      // Note: Styles for TextSpans must be explicitly defined.
                      // Child text spans will inherit styles from parent
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Colors.white70,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'Animation',style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),),
                        TextSpan(
                          text: ' Film',

                        ),
                      ],
                    ),
                  ),
                  Text('See more',style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white24,
                  ),),
                ],
              ),
            ),
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
                return Container(
                );
              }),
            ),
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                pageSnapping: true,
                enlargeCenterPage: true,
                  height:screenHeight*0.2,
                autoPlayCurve: Curves.fastOutSlowIn,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
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
                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                  child: Card(
                    elevation: 6.0,
                    shadowColor: Colors.black,
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
                            width: double.infinity,

                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
