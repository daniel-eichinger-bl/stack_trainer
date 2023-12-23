import 'package:flutter/material.dart';
import 'stack_manager_widgets/stack_input.dart';

class StackCreator extends StatefulWidget {
  static const routeName = '/stack_manager';

  @override
  _StackCreatorState createState() => _StackCreatorState();
}

class _StackCreatorState extends State<StackCreator> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            Text('Stack Creator',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                )),
            Container(
              margin: EdgeInsets.only(left: 8),
              child: Icon(Icons.add_to_photos, size: 35, color: Colors.red),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              onChanged: (value) => setState(() {
                name = value;
              }),
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 1.0),
                ),
              ),
              autofocus: true,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(child: StackInput(name))
        ],
      ),
    );
  }
}
