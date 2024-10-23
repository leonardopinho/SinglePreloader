import 'package:flutter/material.dart';
import 'package:simple_preloader/simple_preloader.dart';

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

class PreloaderContext {
  final String name;
  final PreloaderType type;

  const PreloaderContext({required this.name, required this.type});
}

class MyHomePageState extends State<MyHomePage> {
  late PreloaderContext selectedItem;
  List<PreloaderContext> lst = [
    const PreloaderContext(name: 'Default', type: PreloaderType.DEFAULT),
    const PreloaderContext(name: 'Animated balls', type: PreloaderType.ANIMATED_BALLS),
    const PreloaderContext(name: 'Animated pulse', type: PreloaderType.ANIMATED_PULSE),
    const PreloaderContext(name: 'Animated success', type: PreloaderType.ANIMATED_SUCCESS),
  ];

  @override
  void initState() {
    super.initState();
    selectedItem = lst[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SimplePreloader(
        type: selectedItem.type,
        child: Builder(builder: (context) {
          var preloader = SimplePreloader.of(context)!;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: DropdownMenu<PreloaderContext>(
                    trailingIcon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                    ),
                    initialSelection: selectedItem,
                    requestFocusOnTap: true,
                    textStyle: const TextStyle(color: Colors.black),
                    label: const Text('Curves', style: TextStyle(color: Colors.black)),
                    onSelected: (PreloaderContext? newValue) {
                      setState(() {
                        selectedItem = newValue!;
                      });
                    },
                    menuStyle: MenuStyle(backgroundColor: WidgetStateProperty.all(Colors.grey)),
                    dropdownMenuEntries: lst.map<DropdownMenuEntry<PreloaderContext>>((PreloaderContext item) {
                      return DropdownMenuEntry<PreloaderContext>(
                        value: item,
                        label: item.name,
                        style: MenuItemButton.styleFrom(
                          foregroundColor: Colors.white60,
                          backgroundColor: Colors.black45,
                        ),
                      );
                    }).toList(),
                    inputDecorationTheme: const InputDecorationTheme(
                      isDense: true,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Hit the button to show widget:',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    preloader.show();
                    Future.delayed(const Duration(milliseconds: 3500), () {
                      preloader.hide();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
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
