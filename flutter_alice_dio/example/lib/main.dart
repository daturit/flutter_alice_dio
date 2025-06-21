import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alice_dio/flutter_alice_dio.dart';
import 'package:dio/dio.dart';
import 'package:overlay_support/overlay_support.dart';

// Navigator key
final navigatorKey = GlobalKey<NavigatorState>();

final alice = Alice(navigatorKey: navigatorKey);
final dio = Dio(BaseOptions(followRedirects: false));

void main() {
  if (kDebugMode) dio.interceptors.add(alice.getDioInterceptor());
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        home: Scaffold(
          appBar: AppBar(title: const Text('Alice Inspector')),
          body: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                _textWidget(
                  "Click \"TEST\" button to attach Alice interceptor to Dio\n"
                  " Click \"Open Alice Inspector\" or green bubble to show inspector.",
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    _runDioRequests();
                  },
                  child: Text("TEST", style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  onPressed: alice.showInspector,
                  child: Text("Open Alice Inspector"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textWidget(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 14),
      textAlign: TextAlign.center,
    );
  }

  void _runDioRequests() async {
    Map<String, dynamic> body = {"title": "foo", "body": "bar", "userId": "1"};
    dio.get(
      "https://api.themoviedb.org/3/search/movie?query=Jack+Reacher",
      queryParameters: {"abc": 123},
      data: {"data": "data"},
      options: Options(headers: {"app-id": 1}),
    );
    dio.get("https://httpbin.org/redirect-to?url=https%3A%2F%2Fhttpbin.org");
    dio.delete("https://httpbin.org/status/500");
    dio.delete("https://httpbin.org/status/400");
    dio.delete("https://httpbin.org/status/300");
    dio.delete("https://httpbin.org/status/200");
    dio.delete("https://httpbin.org/status/100");
    dio.post("https://jsonplaceholder.typicode.com/posts", data: body);
    dio.get("https://jsonplaceholder.typicode.com/posts",
        queryParameters: {"test": 1});
    dio.put("https://jsonplaceholder.typicode.com/posts/1", data: body);
    dio.put("https://jsonplaceholder.typicode.com/posts/1", data: body);
    dio.delete("https://jsonplaceholder.typicode.com/posts/1");
    dio.get("http://jsonplaceholder.typicode.com/test/test");

    dio.get("https://jsonplaceholder.typicode.com/photos");
    dio.get(
        "https://icons.iconarchive.com/icons/paomedia/small-n-flat/256/sign-info-icon.png");
    dio.get(
        "https://images.unsplash.com/photo-1542736705-53f0131d1e98?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80");
    dio.get(
        "https://findicons.com/files/icons/1322/world_of_aqua_5/128/bluetooth.png");
    dio.get(
        "https://upload.wikimedia.org/wikipedia/commons/4/4e/Pleiades_large.jpg");
    dio.get("http://techslides.com/demos/sample-videos/small.mp4");

    dio.get("https://www.cse.wustl.edu/~jain/cis677-97/ftp/e_3dlc2.pdf");

    dio.get("http://dummy.restapiexample.com/api/v1/employees");
    dio.get(
        "https://api.lyrics.ovh/v1/Coldplay/Adventure of a Lifetime?artist=Coldplay&title=Adventure of a Lifetime");
  }
}
