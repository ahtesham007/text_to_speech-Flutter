import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Text to speech Vayu'),
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
  final FlutterTts flutterTts = FlutterTts();
  final List<String> _selectedItems = <String>[
    'Chandni chowk',
    'Laxmi nagar',
    'Lawrence Road'
  ];
  final List<String> orderNo = <String>['O07062101', 'O07062102', 'O07062103'];
  final List<String> drop = <String>['Dwarka', 'Karol Bagh', 'Wagah Border'];
  String pickup = 'Select Row';
  String droploc;
  Color color;

  void speak() async {
    await flutterTts.setLanguage("en-IN");
    await flutterTts.setPitch(1.0);
    await flutterTts
        .speak('Pickup Location is ${pickup}. Drop Location is ${droploc}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, textAlign: TextAlign.center),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _selectedItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: ListTile(
              onTap: () {
                if (!_selectedItems.contains(index)) {
                  speak();
                  setState(() {
                    pickup = _selectedItems[index];
                    droploc = drop[index];
                  });
                }
              },
              title: Text('Order Id : ${orderNo[index]}'),
              leading: Icon(Icons.person),
              //trailing: Icon(Icons.keyboard_arrow_right),
              subtitle: Text(
                  'Pickup Location : ${_selectedItems[index]} \nDrop Location : ${drop[index]}'),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: speak,
//        tooltip: 'Speak',
//        child: Icon(Icons.campaign_outlined),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
