import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yugioh Life App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Yugioh Life Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _p1Counter = 8000;
  int _p2Counter = 8000;

  int _p1Thousandth = 1;
  int _p1Hundredth = 0;
  int _p1Tenth = 0;
  int _p1Ones = 0;

  int _p2Thousandth = 1;
  int _p2Hundredth = 0;
  int _p2Tenth = 0;
  int _p2Ones = 0;

  void _setp1Thousandth(int input){
    setState(() {
      _p1Thousandth = input;
    });
  }

  void _setp1Hundredth(int input){
    setState(() {
      _p1Hundredth = input;
    });
  }

  void _setp1Tenth(int input){
    setState(() {
      _p1Tenth = input;
    });
  }

  void _setp1Ones(int input){
    setState(() {
      _p1Ones = input;
    });
  }

  void _setp2Thousandth(int input){
    setState(() {
      _p1Thousandth = input;
    });
  }

  void _setp2Hundredth(int input){
    setState(() {
      _p2Hundredth = input;
    });
  }

  void _setp2Tenth(int input){
    setState(() {
      _p2Tenth = input;
    });
  }

  void _setp2Ones(int input){
    setState(() {
      _p2Ones = input;
    });
  }

  void _addP1Life(){
    setState(() {
      _p1Counter += (_p1Thousandth*1000 + _p1Hundredth *100 + _p1Tenth *10 + _p1Ones);
    });
  }

  void _subP1Life(){
    setState(() {
      _p1Counter -= (_p1Thousandth*1000 + _p1Hundredth *100 + _p1Tenth *10 + _p1Ones);
    });
  }

  void _addP2Life(){
    setState(() {
      _p2Counter += (_p2Thousandth*1000 + _p2Hundredth *100 + _p2Tenth *10 + _p2Ones);
    });
  }

  void _subP2Life(){
    setState(() {
      _p2Counter -= (_p2Thousandth*1000 + _p2Hundredth *100 + _p2Tenth *10 + _p2Ones);
    });
  }

  void _incrementP1Counter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _p1Counter++;
    });
  }
  void _decrementP1Counter() {
    setState(() {
      _p1Counter--;
    });
  }
  void _incrementP2Counter() {
    setState(() {
      _p2Counter++;
    });
  }
  void _decrementP2Counter() {
    setState(() {
      _p2Counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    setPortraitOrientation();
    final _style = Theme.of(context).textTheme.display1;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RotatedBox(
                quarterTurns:2,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Player Two LP',
                      style: TextStyle(fontSize: 50),
                    ),
                    Text(
                      '$_p2Counter',
                      style: TextStyle(fontSize: 50, color: Colors.grey),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          NumberPicker.integer(
                              infiniteLoop: true,
                              initialValue: _p2Thousandth,
                              minValue: 0,
                              maxValue: 9,
                              onChanged: (value) => setState(() => _p2Thousandth = value),
                          listViewWidth: 20,
                          itemExtent: 30,),
                          NumberPicker.integer(
                            infiniteLoop: true,
                            initialValue: _p2Hundredth,
                            minValue: 0,
                            maxValue: 9,
                            onChanged: (value) => setState(() => _p2Hundredth = value),
                            listViewWidth: 20,
                          itemExtent: 30,),
                          NumberPicker.integer(
                            infiniteLoop: true,
                            initialValue: _p2Tenth,
                            minValue: 0,
                            maxValue: 9,
                            onChanged: (value) => setState(() => _p2Tenth = value),
                            listViewWidth: 20,
                            itemExtent: 30,),
                          NumberPicker.integer(
                            infiniteLoop: true,
                            initialValue: _p2Ones,
                            minValue: 0,
                            maxValue: 9,
                            onChanged: (value) => setState(() => _p2Ones = value),
                            listViewWidth: 20,
                            itemExtent: 30,),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: _incrementP2Counter,
                            child: Icon(Icons.add),
                          ),

                          RaisedButton(
                            onPressed: _decrementP2Counter,
                            child: Icon(Icons.remove),
                          ),
                        ]
                    ),
                  ],
                )
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Player One LP',
                  style: TextStyle(fontSize: 50),
                ),
                Text(
                  '$_p1Counter',
                  style: TextStyle(fontSize: 50, color: Colors.grey),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: _incrementP1Counter,
                        child: Icon(Icons.add),
                      ),

                      RaisedButton(
                        onPressed: _decrementP1Counter,
                        child: Icon(Icons.remove),
                      ),
                    ]
                ), // This trailing comma makes auto-formatting nicer for build methods.
              ],

            ),
          ],

        ),
      ),
      floatingActionButton: RaisedButton(
        child: Text('Duel Log'),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DuelLog()),
          );
        },
      ),
    );
  }
}

class DuelLog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Duel Log"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {//go back to LP menu
            Navigator.pop(context);
          },
          child: Text('Return'),
        ),
      ),
    );
  }
}

void setPortraitOrientation(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

void setNormalOrientation(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
