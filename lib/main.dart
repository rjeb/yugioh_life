import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';
import 'dart:math';
import 'fonts/dice_cons_icons.dart';


void main() => runApp(MyApp());

List<int> _p1Counter = [0,0,0,0,0,0,0,0,0,0,0,0];
List<int> _p2Counter = [0,0,0,0,0,0,0,0,0,0,0,0];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yugioh Life App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        brightness: Brightness.dark
      ),
      home: MyHomePage(title: 'Yugioh Life Home Page'),
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
  //LifePoint ariables
  int _p1Counter = 8000;
  int _p2Counter = 8000;


  //variables to track the number scroll wheels
  int _p1Thousandth = 0;
  int _p1Hundredth = 0;
  int _p1Tenth = 0;
  int _p1Ones = 0;

  int _p2Thousandth = 0;
  int _p2Hundredth = 0;
  int _p2Tenth = 0;
  int _p2Ones = 0;

  //A list of a string pair tracks changes in LP, will be displayed in seperate page
  final List<MapEntry<String, String>> _trackedLP = List<MapEntry<String, String>>();

  //setters
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

  //arithmatic functions change LP variables and also adds an element to trackedLP list
  void _addP1Life(){
    setState(() {
      _trackedLP.add(MapEntry("Player 1: " + _p1Counter.toString() + " => " + (_p1Counter += (_p1Thousandth*1000 + _p1Hundredth *100 + _p1Tenth *10 + _p1Ones)).toString() + "               (+" + (_p1Thousandth*1000 + _p1Hundredth *100 + _p1Tenth *10 + _p1Ones).toString() + ")", "Player 2: " + _p2Counter.toString()));
    });
  }

  void _subP1Life(){
    int temp = -1;
    setState(() {
      temp = _p1Counter;
      _p1Counter -= (_p1Thousandth*1000 + _p1Hundredth *100 + _p1Tenth *10 + _p1Ones);
      if(_p1Counter < 0){
        _p1Counter = 0;
      }
      _trackedLP.add(MapEntry("Player 1: " + temp.toString() + " => " + (_p1Counter).toString()  + "               (-" + (_p1Thousandth*1000 + _p1Hundredth *100 + _p1Tenth *10 + _p1Ones).toString()+ ")" , "Player 2: " + _p2Counter.toString()));
    });
  }

  void _addP2Life(){
    setState(() {
      _trackedLP.add(MapEntry("Player 1: " + _p1Counter.toString(), "(+" + (_p2Thousandth*1000 + _p2Hundredth *100 + _p2Tenth *10 + _p2Ones).toString() + ")               " + "Player 2: " + _p2Counter.toString() + " => " + (_p2Counter += (_p2Thousandth*1000 + _p2Hundredth *100 + _p2Tenth *10 + _p2Ones)).toString()));
    });
  }

  void _subP2Life(){
    int temp = -1;
    setState(() {
      temp = _p2Counter;
      _p2Counter -= (_p2Thousandth*1000 + _p2Hundredth *100 + _p2Tenth *10 + _p2Ones);
      if (_p2Counter < 0){
        _p2Counter = 0;
      }
      _trackedLP.add(MapEntry("Player 1: " + _p1Counter.toString(), "(-" + (_p2Thousandth*1000 + _p2Hundredth *100 + _p2Tenth *10 + _p2Ones).toString() + ")               " + "Player 2: " + temp.toString() + " => " +_p2Counter.toString()));
    });
  }

  //unused functions
  void _incrementP1Counter() {
    setState(() {
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

    //screenWidth and screenHeight to have adaptive size for text & elements
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    setPortraitOrientation();
    final _style = Theme.of(context).textTheme.display1;

    return Scaffold(
      /* disabled appbar to preserve space, uncomment to add back
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      */
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Player 2's side is rotated to simultaneous play is possible
            //P2 and P1 always see the screen on their right side
            RotatedBox(
                quarterTurns:2,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Player Two LP',
                      style: TextStyle(fontSize: _screenHeight/11),
                    ),
                    Text(
                      '$_p2Counter',
                      style: TextStyle(fontSize: _screenHeight/6, color: Colors.grey),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //example of scrollwheels to allow plays to select amount of LP to change
                          //each digit is selected seperately
                          NumberPicker.integer(
                              infiniteLoop: true,
                              initialValue: _p2Thousandth,
                              minValue: 0,
                              maxValue: 9,
                              onChanged: (value) => setState(() => _p2Thousandth = value),
                          listViewWidth: _screenWidth/12,
                          itemExtent: _screenHeight/12,),
                          NumberPicker.integer(
                            infiniteLoop: true,
                            initialValue: _p2Hundredth,
                            minValue: 0,
                            maxValue: 9,
                            onChanged: (value) => setState(() => _p2Hundredth = value),
                            listViewWidth: _screenWidth/12,
                          itemExtent: _screenHeight/12,),
                          NumberPicker.integer(
                            infiniteLoop: true,
                            initialValue: _p2Tenth,
                            minValue: 0,
                            maxValue: 9,
                            onChanged: (value) => setState(() => _p2Tenth = value),
                            listViewWidth: _screenWidth/12,
                            itemExtent: _screenHeight/12,),
                          NumberPicker.integer(
                            infiniteLoop: true,
                            initialValue: _p2Ones,
                            minValue: 0,
                            maxValue: 9,
                            onChanged: (value) => setState(() => _p2Ones = value),
                            listViewWidth: _screenWidth/12,
                            itemExtent: _screenHeight/12,),
                        ]
                    ),
                    //Empty text elements to visually seperate buttons from other elements
                    Text('   '),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          MaterialButton(
                            color: Colors.orangeAccent,
                            highlightColor: Colors.amberAccent,
                            minWidth: _screenWidth/5,
                            //onPressed, button adds based on current state of number wheels
                            onPressed: _addP2Life,
                            child: Icon(Icons.add),
                          ),

                          MaterialButton(
                            color: Colors.orangeAccent,
                            highlightColor: Colors.amberAccent,
                            minWidth: _screenWidth/5,
                            onPressed: _subP2Life,
                            child: Icon(Icons.remove),
                          ),
                        ]
                    ),
                    Text(' '),
                    Text(' '),
                  ],
                )
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(' '),
                Text(' '),
                Text(
                  'Player One LP',
                  style: TextStyle(fontSize: _screenHeight/11),
                ),
                Text(
                  '$_p1Counter',
                  style: TextStyle(fontSize: _screenHeight/6, color: Colors.grey),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      NumberPicker.integer(
                        infiniteLoop: true,
                        initialValue: _p1Thousandth,
                        minValue: 0,
                        maxValue: 9,
                        onChanged: (value) => setState(() => _p1Thousandth = value),
                        listViewWidth: _screenWidth/12,
                        itemExtent: _screenHeight/12,),
                      NumberPicker.integer(
                        infiniteLoop: true,
                        initialValue: _p1Hundredth,
                        minValue: 0,
                        maxValue: 9,
                        onChanged: (value) => setState(() => _p1Hundredth = value),
                        listViewWidth: _screenWidth/12,
                        itemExtent: _screenHeight/12,),
                      NumberPicker.integer(
                        infiniteLoop: true,
                        initialValue: _p1Tenth,
                        minValue: 0,
                        maxValue: 9,
                        onChanged: (value) => setState(() => _p1Tenth = value),
                        listViewWidth: _screenWidth/12,
                        itemExtent: _screenHeight/12,),
                      NumberPicker.integer(
                        infiniteLoop: true,
                        initialValue: _p1Ones,
                        minValue: 0,
                        maxValue: 9,
                        onChanged: (value) => setState(() => _p1Ones = value),
                        listViewWidth: _screenWidth/12,
                        itemExtent: _screenHeight/12,),
                    ]
                ),
                //Empty text elements to visually seperate buttons from other elements
                Text('   '),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      MaterialButton(
                        color: Colors.orangeAccent,
                        highlightColor: Colors.amberAccent,
                        minWidth: _screenWidth/5,
                        onPressed: _addP1Life,
                        child: Icon(Icons.add),
                      ),

                      MaterialButton(
                        color: Colors.orangeAccent,
                        highlightColor: Colors.amberAccent,
                        minWidth: _screenWidth/5,
                        onPressed: _subP1Life,
                        child: Icon(Icons.remove),
                      ),
                    ]
                ), // This trailing comma makes auto-formatting nicer for build methods.
              ],

            ),
          ],

        ),
      ),
      persistentFooterButtons: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Counters'),
            //Sends to a page that counters the counters on certain field zones
            IconButton(
              icon: Icon(Icons.arrow_drop_down_circle),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CounterPage()));
              },
            ),
            Text('Coin & Dice'),
            //sends to RandomEvents widget for coin and dice
            IconButton(
              icon: Icon(Icons.casino),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => RandomEvents()));
              },
            ),
            Text('Reset'),
            //Reset button resets players LP and clears all elements in TrackedLP List
            IconButton(
              icon: Icon(Icons.autorenew),
              onPressed: (){
                setState(() {
                  _p1Counter = 8000;
                  _p2Counter = 8000;
                  _trackedLP.clear();
                });
              },
            ),
            Text('Duel Logs'),
            //creates a widget to display tracked LP history
            IconButton(
              icon: Icon(Icons.book),
              onPressed: (){
                Navigator.of(context).push(
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) {
                          final Iterable<ListTile> tiles = _trackedLP.map(
                                (MapEntry<String, String> entry) {
                              return ListTile(
                                leading: Text(entry.key),
                                trailing: Text(entry.value),
                              );
                            },
                          );
                          final List<Widget> listed = ListTile.divideTiles(
                            context: context,
                            tiles: tiles,
                          ).toList();

                          return Scaffold(
                            appBar: AppBar(
                              title: Text('Lifepoint Calculations'),
                            ),
                            body: ListView(children: listed),
                          );
                        }
                    )
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

//counter page for tracking counters
class CounterPage extends StatefulWidget {
  CounterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {

  //variables will track 5 monster, 5 s/t zones, and 1 field spell zone for ea player
  List<int> _p1Counters = _p1Counter;
  List<int> _p2Counters = _p2Counter;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    setPortraitOrientation();
    final _style = Theme.of(context).textTheme.display1;

    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                        builder:
                            (context, List<int> candidateData, rejectedData) {
                          return Container(
                            width: _screenWidth/12,
                            height: _screenHeight/6.5,
                            child: Center(
                              child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(0).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                onDragStarted: (){
                                    setState(() {
                                      _p1Counters[0]--;
                                    });
                                },
                              ),
                            ),
                            color: Colors.transparent,
                          );
                        },
                        onWillAccept: (data){
                          if(data == 1){
                            return true;
                          }
                          else{

                          }
                        },
                        onAccept: (data) {
                          setState(() {
                            _p1Counters[0]++;
                          });
                        }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(1).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[1]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[1]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(2).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[2]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[2]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(3).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[3]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[3]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(4).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[4]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[4]++;
                            });
                          }
                      ),
                    ],
                  ),
                  Text(''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(5).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[5]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[5]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(6).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[6]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[6]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(7).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[7]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[7]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(8).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[8]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[8]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(9).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[9]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[9]++;
                            });
                          }
                      ),
                    ],
                  ),
                  Text(''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/10,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(10).toString()),
                                    ),
                                    color: Colors.blueGrey,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[10]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[10]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p1Counters.elementAt(11).toString()),
                                    ),
                                    color: Colors.grey,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p1Counters[11]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p1Counters[11]++;
                            });
                          }
                      ),
                      Container(
                        width: _screenWidth/12,
                        height: _screenHeight/6.5,
                        child: Center(
                          child: Draggable(
                              data: 1,
                              child: Container(
                                width: _screenWidth/12,
                                height: _screenHeight/6.5,
                                child: Icon(Icons.add_circle_outline),
                              ),
                              feedback: Container(
                                width: _screenWidth/12,
                                height: _screenHeight/6.5,
                                child: Icon(Icons.add_circle_outline),
                              )),
                        ),
                        color: Colors.transparent,
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(11).toString()),
                                    ),
                                    color: Colors.grey,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[11]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[11]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/10,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(10).toString()),
                                    ),
                                    color: Colors.blueGrey,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[10]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[10]++;
                            });
                          }
                      ),

                    ],
                  ),
                  Text(''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(9).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[9]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[9]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(8).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[8]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[8]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(7).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[7]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[7]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(6).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[6]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[6]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(5).toString()),
                                    ),
                                    color: Colors.orangeAccent,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[5]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[5]++;
                            });
                          }
                      ),
                    ],
                  ),
                  Text(''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(4).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[4]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[4]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(3).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[3]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[3]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(2).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[2]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[2]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(1).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[1]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[1]++;
                            });
                          }
                      ),
                      DragTarget(
                          builder:
                              (context, List<int> candidateData, rejectedData) {
                            return Container(
                              width: _screenWidth/12,
                              height: _screenHeight/6.5,
                              child: Center(
                                child: Draggable(
                                  data: 1,
                                  child: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Center(
                                      child: Text(_p2Counters.elementAt(0).toString()),
                                    ),
                                    color: Colors.teal,
                                  ),
                                  feedback: Container(
                                    width: _screenWidth/12,
                                    height: _screenHeight/6.5,
                                    child: Icon(Icons.add_circle_outline),
                                  ),
                                  onDragStarted: (){
                                    setState(() {
                                      _p2Counters[0]--;
                                    });
                                  },
                                ),
                              ),
                              color: Colors.transparent,
                            );
                          },
                          onWillAccept: (data){
                            if(data == 1){
                              return true;
                            }
                            else{

                            }
                          },
                          onAccept: (data) {
                            setState(() {
                              _p2Counters[0]++;
                            });
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ]
        ),
      ),
    );
  }

}


//RandomEvents widget handles dice and coins
class RandomEvents extends StatefulWidget {
  RandomEvents({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RandomEventsState createState() => _RandomEventsState();
}

class _RandomEventsState extends State<RandomEvents> {
  final _random = new Random();

  //initial settings for coin and dice
  IconData _coin = Icons.monetization_on;
  IconData _dice = DiceCons.dice1;

  String _coinText = "Heads";
  String _diceText = "One";

  //Array of possible icons and Strings for dice
  var _diceIcons = [DiceCons.dice1, DiceCons.dice2, DiceCons.dice3, DiceCons.dice4, DiceCons.dice5, DiceCons.dice6];
  var _diceStrings = ["One", "Two", "Three", "Four", "Five", "Six"];

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;

    setPortraitOrientation();
    final _style = Theme.of(context).textTheme.display1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coin and Dice'),
      ),
      body: Center(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(_coinText,
                    style: TextStyle(fontSize: _screenHeight/8),),
                  IconButton(
                    icon: Icon(_coin),
                    iconSize: _screenHeight/3,
                    onPressed: (){
                      setState(() {
                        _flipCoin();
                      });
                    },
                  ),
                ],
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(_diceText,
                    style: TextStyle(fontSize: _screenHeight/8),),
                  IconButton(
                    icon: Icon(_dice),
                    iconSize: _screenHeight/3,
                    onPressed: (){
                      setState(() {
                        _rollDice();
                      });
                    },
                  ),
                ],
              ),


            ]
        ),
      ),
    );
  }

  //sets CoinText and coinIcon based on randomly generated number (0-1)
  void _flipCoin(){
    int temp = _random.nextInt(100);
    print(temp);
    if (temp%2 == 0){
      _coin = Icons.monetization_on;
      _coinText = "Heads";
    }
    else{
      _coin = Icons.cancel;
      _coinText = "Tails";
    }
  }

  //sets DiceText and DiceIcon based on randomly generated number (0-5)
  void _rollDice(){
    int temp = _random.nextInt(6);
    _dice = _diceIcons.elementAt(temp);
    _diceText = _diceStrings.elementAt(temp);
  }
}

//sets app to portrait orientation
void setPortraitOrientation(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

//sets app to normal orientation
void setNormalOrientation(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}
