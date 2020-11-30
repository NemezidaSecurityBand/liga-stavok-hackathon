import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:liga_stavok/model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xff007354),
        accentColor: Colors.cyan[600],
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController controller = PageController();
  var currentPageValue = 0.0;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var borderCornerRadius = 5.0;
    return Scaffold(
        backgroundColor: Color(0xffE5E5E5),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Card(
                elevation: 4,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.transparent, width: 1),
                    borderRadius: BorderRadius.circular(borderCornerRadius)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderCornerRadius),
                  child: Column(
                    children: [
                      _buildWidgetTitle(),
                      Flexible(
                        flex: 1,
                        child: PageView.builder(
                          controller: controller,
                          itemBuilder: (context, position) {
                            if (position == currentPageValue.floor()) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..rotateY(currentPageValue - position)
                                  ..rotateZ(currentPageValue - position),
                                child: _buildWidgetContentPage(),
                              );
                            } else if (position ==
                                currentPageValue.floor() + 1) {
                              return Transform(
                                transform: Matrix4.identity()
                                  ..rotateY(currentPageValue - position)
                                  ..rotateZ(currentPageValue - position),
                                child: _buildWidgetContentPage(),
                              );
                            } else {
                              return _buildWidgetContentPage();
                            }
                          },
                          itemCount: 5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(flex: 1, child: Container())
          ],
        ));
  }

  Container _buildWidgetTitle() {
    return Container(
      color: Color(0xff007354),
      child: Row(
        children: [
          SizedBox(width: 128, child: Image.asset('assets/images/logo.png')),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SizedBox(
                width: 24, child: Image.asset('assets/images/bell.png')),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Text(
              '14:33',
              style: TextStyle(
                  fontFamily: 'SF', fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildWidgetContentPage() {
    var gameItem1 = GameItem();
    gameItem1.command1 = 'Манчестер Юнайтед';
    gameItem1.command2 = 'Локомотив';
    gameItem1.currentTime = '90 минут';
    gameItem1.startTime = '12:00';
    gameItem1.startDate = '29-е ноября';
    gameItem1.isActive = true;
    gameItem1.gameStatus = 0;
    gameItem1.score1 = 1;
    gameItem1.score12 = 0;
    gameItem1.score2 = 2;
    gameItem1.score22 = 2;
    gameItem1.score3 = 0;
    gameItem1.score32 = 0;

    var gameItem2 = GameItem();
    gameItem2.command1 = 'Спартак';
    gameItem2.command2 = 'Зенит';
    gameItem2.currentTime = '90 минут';
    gameItem2.startTime = '12:00';
    gameItem2.startDate = '29-е ноября';
    gameItem2.isActive = false;

    var gameItem3 = GameItem();
    gameItem3.command1 = 'Барселона';
    gameItem3.command2 = 'Ливерпуль';
    gameItem3.currentTime = '90 минут';
    gameItem3.startTime = '12:00';
    gameItem3.startDate = '29-е ноября';
    gameItem3.isActive = false;

    var gameItems = [
      _buildGameRow(gameItem1),
      _buildGameRow(gameItem2),
      _buildGameRow(gameItem3),
    ];
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Wrap(
          runSpacing: 6.0,
          children: gameItems,
        ),
      ),
    );
  }

  Widget _buildGameRow(GameItem item) {
    return Card(
      child: Stack(children: [
        Column(
          children: [
            Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 40.0)),
                    Text(item.currentTime,
                        style: TextStyle(
                            fontSize: 9,
                            color: Color(
                                !item.isActive ? 0x00ffffff : 0xff000000))),
                    Container(
                      width: 28,
                    ),
                    Text('Матч завершен',
                        style: TextStyle(
                            fontSize: 9,
                            color: Color(item.isActive && item.gameStatus == 0
                                ? 0xff009A6E
                                : 0x00ffffff))),
                    Container(
                      width: 48,
                    ),
                    Text('Победитель',
                        style: TextStyle(
                          fontSize: 9,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(item.startDate,
                    style: TextStyle(
                      fontSize: 9,
                      color: Color(item.isActive ? 0x00ffffff : 0xff000000),
                    )),
              ),
              Visibility(
                visible: item.isActive,
                child: Card(
                    color: Color(0xFFFFA100),
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.transparent, width: 1),
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 7, top: 2, right: 7, bottom: 2),
                      child: Text(
                        'LIVE',
                        style: TextStyle(
                          fontFamily: 'SF',
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    )),
              )
            ]),
            Container(
              color: Colors.transparent, //todo: remove it
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8, top: 10.0, bottom: 10),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        item.startTime,
                        style:
                            TextStyle(color: Color(0xff797979), fontSize: 10.0),
                      ),
                    ),
                  ),
                  buildVerticalDivider(),
                  SizedBox(
                    width: 110,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.command1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0),
                        ),
                        Container(
                          height: 4,
                        ),
                        Text(
                          item.command2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: !item.isActive,
                    child: Container(
                      width: 20,
                    ),
                  ),
                  Visibility(
                    visible: item.isActive,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "${item.score1} ",
                                style: TextStyle(
                                    fontSize: 9, color: Color(0xff797979))),
                            TextSpan(
                                text: "${item.score2} ",
                                style: TextStyle(
                                    fontSize: 9, color: Color(0xff009A6E))),
                            TextSpan(
                                text: "${item.score3}",
                                style: TextStyle(
                                    fontSize: 9, color: Color(0xffFFA100))),
                          ]),
                        ),
                        Container(
                          height: 4,
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "${item.score12} ",
                                style: TextStyle(
                                    fontSize: 9, color: Color(0xff797979))),
                            TextSpan(
                                text: "${item.score22} ",
                                style: TextStyle(
                                    fontSize: 9, color: Color(0xff009A6E))),
                            TextSpan(
                                text: "${item.score32}",
                                style: TextStyle(
                                    fontSize: 9, color: Color(0xffFFA100))),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  buildVerticalDivider(),
                  Spacer(),
                  Text(
                    '4,55',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  buildVerticalDivider(height: 21),
                  Text(
                    '4,55',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  buildVerticalDivider(height: 21),
                  Text(
                    '4,55',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 10.0),
                  ),
                  Spacer(),
                  buildVerticalDivider(),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(width: 24, child: null),
                  )
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 23),
            child: SizedBox(
                width: 24, child: Image.asset('assets/images/chart.png')),
          ),
        )
      ]),
    );
  }

  Container buildVerticalDivider({double height = 28}) {
    return Container(
      height: height,
      width: 1.0,
      color: Color(0xFFC4C4C4),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
    );
  }
}
