import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:winson_wings/Common%20Widgets.dart';

class Dash extends StatefulWidget {
  const Dash({super.key});

  @override
  _DashState createState() => _DashState();
}

class _DashState extends State<Dash> {
  List<dynamic> _data = [];
bool add=false;
  final String apiUrl = 'https://api.example.com/save_data';
TextEditingController power=TextEditingController();
TextEditingController name=TextEditingController();
  Future<void> _fetchData() async {
    final response = await http.get(Uri.parse('https://dev-ml50228eiilnw45.api.raw-labs.com/json-programming-heroes'));
    if (response.statusCode == 200) {
      setState(() {
        _data = json.decode(response.body);
      });
    } else {
      print('Failed to load data. Error: ${response.statusCode}');
    }
  }

  Future<void> _saveData(var data) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      print('Data saved successfully.');
    } else {
      print('Failed to save data. Error: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        child: Container(
          width: 700,
          height: 700,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  height: 380,
                  child:ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 10,
                        child: ListTile(
                          title: Text(_data[index]['hero_name']),
                          subtitle: Text(_data[index]['hero_superpower']),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: (){
                    add=true;
                    setState(() {

                    });
                  }, child: const Text("Add Data"))
                ],
              ),
              Visibility(
                visible: add,
                  child: Column(
                    children: [
                      Common.CmnTxtFld(name, "Name", true, 50, 150),
                      const SizedBox(height: 10,),
                      Common.CmnTxtFld(power, "Power", true, 50, 250),
                      const SizedBox(height: 10,),
                      ElevatedButton(onPressed: (){
                        Map pp = {name.text:power.text};
                        _data.add(pp);
                        _saveData(_data);
                      }, child: const Text("Send Data"))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}