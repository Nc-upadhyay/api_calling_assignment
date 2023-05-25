import 'dart:convert';

import 'package:abhisek_internship_assignment/data_model.dart';
import 'package:http/http.dart' as http;

class FetchData {
  static Future<List<DataModel>> fetchData(int i) async
  {
    var url=Uri.parse("https://www.maheshwari.org/api/successstory/list?PageNumber=$i");
    var response=await http.get(url);
    if(response.statusCode==200)
      {
        // print("============== response is ${response.body}");
        Map j=json.decode(response.body);
        List d=j["Items"];
        // print("list =================== ${d}");
        return d.map((data)=>DataModel.fromJson(data)).toList();
      }else{
      print("===============error");
      throw Exception('Unexpected error occured!');
    }
  }
}