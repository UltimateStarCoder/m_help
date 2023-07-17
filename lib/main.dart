import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Leave Projector'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final myController = TextEditingController();
  TextEditingController cardController = TextEditingController();

  final List<String> names = <String>["cae"];
  final List<int> leaveLeft = <int>[];

  void addItemToList() {
    setState(() {
      names.add(cardController.text);
      leaveLeft.insert(0, -1);
    });
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Total Current Leave: $_counter',
            ),
            ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  // title: const Text('AlertDialog Title'),
                  // content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    TextFormField(
                      controller: myController,
                      decoration: const InputDecoration(
                          labelText: "Enter your current leave days",
                          counterText: ""),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cancel');
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _counter = int.tryParse(myController.text) ?? 0;
                        });
                        Navigator.pop(context, 'OK');
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              ),
              child: const Text('Update Current Leave Days'),
            ),
            const Divider(
              thickness: 7,
            ),
            const SizedBox(
              height: 4,
            ),

            Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: names.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      height: 23,
                      margin: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          names[index],
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }),
            ),
            //ListView.builder(itemBuilder: itemBuilder)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            // title: const Text('AlertDialog Title'),
            // content: const Text('AlertDialog description'),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  controller: cardController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Leave Name',
                  ),
                ),
              ),
              TextFormField(
                controller: cardController,
                decoration: const InputDecoration(
                    labelText: "Enter your current leave plan"),
              ),
              ElevatedButton(
                  onPressed: () {
                    addItemToList();
                    Navigator.pop(context, 'Add');
                  },
                  child: const Text("Add")),
            ],
          ),
        ),
        tooltip: 'Leave Plan',
        child: const Icon(Icons.add),
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
