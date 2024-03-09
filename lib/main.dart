// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:blogclub/data.dart';
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
    final Color primaryFontColor = Color(0xff0D253C);
    final Color secondaryFontColor = Color(0xff2D4379);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true,
          textTheme: TextTheme(
              headline6: TextStyle(
                fontFamily: defaultFontFamily,
                fontWeight: FontWeight.bold,
                color: primaryFontColor,
              ),
              subtitle1: TextStyle(
                fontFamily: defaultFontFamily,
                color: secondaryFontColor,
              ),
              bodyText2: TextStyle(
                  fontFamily: defaultFontFamily,
                  color: secondaryFontColor,
                  fontSize: 12))),
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
        physics: BouncingScrollPhysics(),
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
                padding: const EdgeInsets.fromLTRB(32, 0, 32, 24),
                child: Row(
                  children: [
                    Text('Explore today’s', style: textThemeData.headline6),
                  ],
                ),
              ),
              _StoryList(stories: stories, textThemeData: textThemeData)
            ],
          ),
        ),
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
        padding: EdgeInsets.fromLTRB(32, 0, 32, 0),
        physics: BouncingScrollPhysics(),
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
      margin: EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: (Column(
        children: [
          Stack(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient:
                        LinearGradient(begin: Alignment.topLeft, colors: const [
                      Color(0xff376AED),
                      Color(0xff49B0E2),
                      Color(0xff9CECFB),
                    ])),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.white),
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17),
                    child: Image.asset(
                        'assets/img/stories/${story.imageFileName}'),
                  ),
                ),
              ),
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
          SizedBox(
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
}
