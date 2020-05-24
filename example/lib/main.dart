import 'package:flutter/material.dart';
import 'package:singlepreloader/singlepreloader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'singlepreloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Single preloader Demo'),
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
  var _progress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SinglePreloader(
        child: Builder(builder: (context) {
          _progress = SinglePreloader.of(context);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Hit the button to show widget:',
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    _progress.show();
                    Future.delayed(Duration(milliseconds: 3000), () {
                      _progress.hide();
                    });
                  },
                  color: Colors.grey[500],
                  child: Text(
                    "Show",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}