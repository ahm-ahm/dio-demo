import 'package:dio_practice/web-services/placeholder_api.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: FutureBuilder(future: getPost(),builder: (context,asyncSnapshotData){
        if(asyncSnapshotData.hasData){
          var data=asyncSnapshotData.data;
        return  ListView.builder(
              itemCount: data.length,
              itemBuilder: (context,index){
            return Card(child: ListTile(title: Text(data[index]['title']),));
          });
        }
        return const Center(child:CircularProgressIndicator());
      },),
    );
  }
}
