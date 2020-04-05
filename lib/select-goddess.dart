import 'package:fertile_affirmations/card-class.dart';
import 'package:fertile_affirmations/main.dart';
import "package:flutter/material.dart";

class SelectGoddess extends StatefulWidget {
  SelectGoddess({Key key}) : super(key: key);

  @override
  _SelectGoddess createState() => _SelectGoddess();
}

class _SelectGoddess extends State<SelectGoddess> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Image.asset('assets/images/noleaves2.png'),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: MediaQuery.of(context).size.height / 6),
            SizedBox(height: MediaQuery.of(context).size.height / 10),

            Container(
              height: MediaQuery.of(context).size.height / 6,
              alignment: Alignment.center,
              child: Image.asset('assets/images/fertilelogo.png'),
            ),
            // SizedBox(height: 30),
            SizedBox(height: MediaQuery.of(context).size.height / 12),

            Container(
                alignment: Alignment.center,
                height: (MediaQuery.of(context).size.height / 6) * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 2.5,
                      child: ConstrainedBox(
                        constraints: BoxConstraints.expand(),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            CardClass.setPreference(false);
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyHomePage(preference: false),
                                ));
                          },
                          child: Image.asset('assets/images/warmfirst.png'),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 5,
                    ),

                    GestureDetector(
                        onTap: () {
                          CardClass.setPreference(true);

                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyHomePage(preference: true),
                              ));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2 - 2.5,
                          child:
                              Image.asset('assets/images/porcelainfirst.png'),
                        ))
                  ],
                )),
            SizedBox(height: MediaQuery.of(context).size.height / 12),

            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 4 * 3,
              height: MediaQuery.of(context).size.height / 6,
              child: Image.asset('assets/images/selectimage.png'),
            ),

          ],
        ),
      ],
    );
  }
}
