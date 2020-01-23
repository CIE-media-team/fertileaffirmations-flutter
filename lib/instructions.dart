import 'package:fertile_affirmations/card-class.dart';
import 'package:flutter/material.dart';
import 'card-class.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dots_indicator/dots_indicator.dart';

class InstructionScreen extends StatefulWidget {
  InstructionScreen({
    Key key,
    this.card,
    @required this.instructions,
    @required this.position,
  }) : super(key: key);
  final CardClass card;
  final int position;
  final List instructions;

  @override
  _InstructionScreen createState() => _InstructionScreen();
}

class _InstructionScreen extends State<InstructionScreen> {
  int totalDots;
  double _currentPosition = 0.0;
  @override
  Widget build(BuildContext context) {
    totalDots = widget.instructions.length - 1;
    final decorator = DotsDecorator(
      activeColor: Theme.of(context).primaryColorDark,
      color: Theme.of(context).primaryColor,
      activeSize: Size.square(18.0),
    );

    return Stack(children: <Widget>[
      Image(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
        image: AssetImage('assets/images/noleaves2.png'),
      ),
      Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Instructions', style: TextStyle(fontSize: 30)),
            automaticallyImplyLeading: true,
            //`true` if you want Flutter to automatically add Back Button when needed,
            //or `false` if you want to force your own back button every where
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(children: <Widget>[
                Expanded(
                    child: PageView.builder(
                        itemCount: CardClass.instructions.length - 1,
                        onPageChanged: _pageChange,
                        controller: PageController(
                            initialPage: widget.position,
                            keepPage: true,
                            viewportFraction: 1),
                        itemBuilder: (context, position) {
                          return Column(children: <Widget>[
                            Expanded(
                                child: Stack(children: <Widget>[
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  height: (MediaQuery.of(context).size.height /
                                      5 *
                                      4),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                    'assets/images/cardBlanknew.png',
                                  ))),
                                  child: Center(
                                      child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 20),

                                          // decoration: BoxDecoration(
                                          //   border: Border.all(color: Colors.black)
                                          // ),
                                          width: ((MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4) *
                                                  3) *
                                              0.55,
                                          height: ((MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      4) *
                                                  3) *
                                              0.7,
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  widget.instructions[position],
                                                  // minFontSize: 12,
                                                  // maxFontSize: 40,
                                                  style: TextStyle(
                                                      fontSize: getFontSize(),
                                                      height: 1.1,
                                                      color: Color(0xff41311F)),
                                                  textAlign:
                                                      TextAlign.center)))))
                            ])),
                          ]);
                        })),
                Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: DotsIndicator(
                      dotsCount: totalDots,
                      position: _currentPosition,
                      decorator: decorator,
                    ))
              ])))
    ]);
  }

  _pageChange(int position) {
    setState(() => _currentPosition = _validPosition(position).toDouble());
  }

  int _validPosition(int position) {
    if (position >= totalDots) return 0;
    if (position < 0) return totalDots - 1;
    return position;
  }

  double getFontSize() {
    double fontsize = (MediaQuery.of(context).size.height) / 35;
    if (MediaQuery.of(context).size.height > 800) {
      fontsize = (MediaQuery.of(context).size.height) / 40;
    }
    return fontsize;
  }
}
