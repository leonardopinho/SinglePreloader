import 'package:flutter/material.dart';
import 'package:singlepreloader/single_preloader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'singlepreloader',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Single preloader Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  late final _progress;

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
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Hit the button to show widget:',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _progress.show();
                    Future.delayed(const Duration(milliseconds: 3000), () {
                      _progress.hide();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                  ),
                  child: const Text(
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
