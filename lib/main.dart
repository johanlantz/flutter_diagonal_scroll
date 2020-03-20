import 'package:flutter/material.dart';
import 'package:diagonal_scrollview/diagonal_scrollview.dart';

String _appTitle = 'Example App';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: _appTitle,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp();

  final double _boxSize = 1000.0;
  final Color _boxColor = Colors.white70;
  DiagonalScrollViewController scrollController;

  List<Widget> _getChildren() {
    List<Widget> children = [];
    Color childColor = Colors.blueGrey;
    double childSize = 100.0;
    double childMargin = 20;
    double tmpNumChildrenRow = _boxSize / childSize;
    num numChildren = (_boxSize - tmpNumChildrenRow * childMargin) / childSize;

    for (num x = 0; x < numChildren; x++) {
      for (num y = 0; y < numChildren; y++) {
        Widget cube = Container(
          width: childSize,
          height: childSize,
          color: childColor,
        );

        children.add(Positioned(
          left: childMargin + (childMargin + childSize) * x,
          top: childMargin + (childMargin + childSize) * y,
          child: cube,
        ));
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            scrollController.moveTo(location: Offset(1000, 1000));
            //scrollController.moveBy(offset: Offset(1000, 1000));
          },
          child: Text(_appTitle)),
        
      ),
      body: DiagonalScrollView(
        enableFling: true,
        enableZoom: false,
        maxHeight: _boxSize,
        maxWidth: _boxSize,
        onCreated: (DiagonalScrollViewController controller) {
          scrollController = controller;
        },
        child: Container(
          
          decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img1.jpeg"),
            fit: BoxFit.cover,
          )),
          width: _boxSize,
          height: _boxSize,
          // color: _boxColor,
          child: Stack(
            children: _getChildren(),
          ),
        ),
      ),
    );
  }
}