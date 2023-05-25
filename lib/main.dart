import 'package:abhisek_internship_assignment/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_model.dart';
import 'fetch_data.dart';
import 'list_view_builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => DataProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFirstPage = true;

  @override
  void initState() {
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white30, Colors.white70],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width:200,
              child: TextField(
                controller: TextEditingController(),
                style: const TextStyle(color: Colors.blue),
                cursorColor: Colors.black,

                decoration:
                    const InputDecoration(fillColor: Colors.red,hintText: "Search by profile,id,name...",),
                onTap: () {},
                onChanged: (value) {},
              ),
            ),
            const Icon(Icons.search_rounded,size: 30,)
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(5),
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
          ],
        ),
      ),
      body: ListView(scrollDirection: Axis.vertical, children: [
        const SizedBox(
          height: 5,
        ),

        const SizedBox(height: 615, child: ListViewBuilder()),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () async {
                    Provider.of<DataProvider>(context, listen: false)
                        .pageNumber--;
                    if (Provider.of<DataProvider>(context, listen: false)
                            .pageNumber ==
                        1) {
                      isFirstPage = true;
                      setState(() {});
                    }
                    List<DataModel> cur = await FetchData.fetchData(
                        Provider.of<DataProvider>(context, listen: false)
                            .pageNumber);
                    Provider.of<DataProvider>(context, listen: false)
                        .currentListModify(cur);
                  },
                  child: isFirstPage ? Text("") : Text("prev")),
              Text(
                "${Provider.of<DataProvider>(context, listen: false).pageNumber}",
                style: TextStyle(color: Colors.blue),
              ),
              TextButton(
                  onPressed: () async {
                    Provider.of<DataProvider>(context, listen: false)
                        .pageNumber++;
                    isFirstPage = false;
                    setState(() {});
                    List<DataModel> cur = await FetchData.fetchData(
                        Provider.of<DataProvider>(context, listen: false)
                            .pageNumber);
                    Provider.of<DataProvider>(context, listen: false)
                        .currentListModify(cur);
                    print(
                        "main=========  ${await FetchData.fetchData(Provider.of<DataProvider>(context, listen: false).pageNumber)}");
                  },
                  child: Text("next")),
            ],
          ),
        ),
      ]), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void initialise() async {
    List<DataModel> cur = await FetchData.fetchData(1);
    print("ini========${cur}");
    Provider.of<DataProvider>(context, listen: false).currentListModify(cur);
  }
}
