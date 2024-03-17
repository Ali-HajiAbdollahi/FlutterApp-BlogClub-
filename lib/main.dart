// ignore_for_file: deprecated_member_use

import 'package:blogclub/carousel/carousel_slider.dart';
import 'package:blogclub/data.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const defaultFontFamily = 'Avenir';
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Color primaryFontColor = Color(0xff0D253C);
    const Color secondaryFontColor = Color(0xff2D4379);
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: true,
          textTheme: const TextTheme(
              headline6: TextStyle(
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: primaryFontColor,
              ),
              subtitle1: TextStyle(
                fontFamily: defaultFontFamily,
                color: secondaryFontColor,
              ),
              bodyText2: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: secondaryFontColor,
                  fontSize: 12),
              headline4: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: primaryFontColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w700))),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textThemeData = Theme.of(context).textTheme;
    final stories = AppDatabase.stories;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hi Jonathan!',
                      style: textThemeData.subtitle1,
                    ),
                    Image.asset(
                      'assets/img/icons/notification.png',
                      width: 32,
                      height: 32,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 16),
                child: Row(
                  children: [
                    Text('Explore today’s', style: textThemeData.headline4),
                  ],
                ),
              ),
              _StoryList(stories: stories, textThemeData: textThemeData),
              const SizedBox(
                height: 16,
              ),
              const _CategoryList()
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList();
  @override
  Widget build(BuildContext context) {
    final categories = AppDatabase.categories;
    return CarouselSlider.builder(
        itemCount: categories.length,
        itemBuilder: (context, index, realIndex) {
          return _CategoryItem(
            category: categories[realIndex],
            left: realIndex == 0 ? 32 : 8,
            right: realIndex == categories.length - 1 ? 32 : 8,
          );
        },
        options: CarouselOptions(
            initialPage: 0,
            disableCenter: true,
            enableInfiniteScroll: false,
            aspectRatio: 1.2,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.8,
            scrollPhysics: const BouncingScrollPhysics(),
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height));
  }
}

class _CategoryItem extends StatelessWidget {
  final Category category;
  final double left;
  final double right;
  const _CategoryItem(
      {required this.category, required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Stack(
        children: [
          Positioned.fill(
              left: 55,
              right: 55,
              top: 60,
              bottom: 24,
              child: Container(
                decoration: const BoxDecoration(boxShadow: [
                  BoxShadow(color: Color(0xff0D253C), blurRadius: 20),
                ]),
              )),
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(32),
              ),
              foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [Color(0xff0D253C), Colors.transparent])),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.asset(
                  'assets/img/posts/large/${category.imageFileName}',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            left: 42,
            bottom: 48,
            child: Text(category.title,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .apply(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _StoryList extends StatelessWidget {
  const _StoryList({
    required this.stories,
    required this.textThemeData,
  });

  final List<StoryData> stories;
  final TextTheme textThemeData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 93,
      child: ListView.builder(
        itemCount: stories.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final story = stories[index];
          return _Story(story: story, textThemeData: textThemeData);
        },
      ),
    );
  }
}

class _Story extends StatelessWidget {
  const _Story({
    required this.story,
    required this.textThemeData,
  });

  final StoryData story;
  final TextTheme textThemeData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: (Column(
        children: [
          Stack(
            children: [
              story.isViewed ? _viewedStory() : _unViewedStory(),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  'assets/img/icons/${story.iconFileName}',
                  width: 24,
                  height: 24,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            story.name,
            style: textThemeData.bodyText2,
          ),
        ],
      )),
    );
  }

  Container _unViewedStory() {
    return Container(
      width: 68,
      height: 68,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: const LinearGradient(begin: Alignment.topLeft, colors: [
            Color(0xff376AED),
            Color(0xff49B0E2),
            Color(0xff9CECFB),
          ])),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22), color: Colors.white),
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        child: _profileImage(),
      ),
    );
  }

  Widget _viewedStory() {
    return SizedBox(
      width: 68,
      height: 68,
      child: DottedBorder(
        borderPadding: const EdgeInsets.all(1),
        borderType: BorderType.RRect,
        radius: const Radius.circular(24),
        color: const Color(0xff7B8BB2),
        strokeWidth: 2,
        dashPattern: const [7, 4],
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: _profileImage(),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(17),
      child: Image.asset('assets/img/stories/${story.imageFileName}'),
    );
  }
}
