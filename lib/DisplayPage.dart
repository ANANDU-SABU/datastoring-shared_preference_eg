import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisplayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Page'),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${snapshot.data?['name']}'),
                  Text('Designation: ${snapshot.data?['designation']}'),
                  Text('Mobile Number: ${snapshot.data?['mobile']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Future<Map<String, String>> _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String name = prefs.getString('name') ?? '';
    String designation = prefs.getString('designation') ?? '';
    String mobile = prefs.getString('mobile') ?? '';

    return {'name': name, 'designation': designation, 'mobile': mobile};
  }
}