import 'package:abhisek_internship_assignment/data_provider.dart';
import 'package:abhisek_internship_assignment/web_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_model.dart';

class ListViewBuilder extends StatefulWidget {
  const ListViewBuilder({super.key});

  @override
  State<ListViewBuilder> createState() => _ListViewBuilderState();
}

class _ListViewBuilderState extends State<ListViewBuilder> {
  List<DataModel> listOfData = [];

  @override
  Widget build(BuildContext context) {
    listOfData = Provider.of<DataProvider>(context, listen: false).current;
    print(
        "list view===========${Provider.of<DataProvider>(context, listen: true).current}");
    return Consumer<DataProvider>(
      builder: (context, data, child) => SizedBox(
        child: ListView.builder(
            itemCount: data.current.length,
            itemBuilder: (context, index) {
              String story = data.current[index].story;
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.network(
                        "https://www.maheshwari.org/${data.current[index].couplePhoto}",
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      Text(
                        data.current[index].coupleName,
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      story.length < 80
                          ? Text(story)
                          : Text(story.substring(0, 80)),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebViewExample(
                                        url:
                                            "https://www.maheshwari.org/user/success-story.aspx?storyId=${data.current[index].storyId}")));
                          },
                          child: const Text(
                            "Read More",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
