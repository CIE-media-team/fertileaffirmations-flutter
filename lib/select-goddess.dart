import "package:flutter/material.dart"; 

class SelectGoddess extends StatefulWidget{
  SelectGoddess({Key key}) : super(key: key);

  @override
  _SelectGoddess createState() => _SelectGoddess();
}

class _SelectGoddess extends State<SelectGoddess> {

  @override
  Widget build(BuildContext context){
return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text("select"),
          ),
            body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Stack(
              
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('assets/images/noleaves2.png'),
                  ),
                ),
                Image.asset('assets/images/cardblank.png'),
      
                
          ]
              
            
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



