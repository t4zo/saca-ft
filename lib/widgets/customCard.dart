import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  CustomCard({@required this.index, @required this.onPress});

  final index;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          Text('Card $index'),
          FlatButton(
            child: const Text('Press'),
            onPressed:  this.onPress,
          ),
        ],
      ),
    );
  }
}