import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'HTTP Playground';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: appTitle),
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
  var _response = '';
  final String _fetchAddress = 'https://jsonplaceholder.typicode.com/albums/1';

  Future<void> _fetchAlbum() async {
    final response = await http.get(
      Uri.parse(_fetchAddress),
    );

    if (response.statusCode == 200) {
      setState(() {
        _response = response.body;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_response),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchAlbum,
        tooltip: 'Fetch Album',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
