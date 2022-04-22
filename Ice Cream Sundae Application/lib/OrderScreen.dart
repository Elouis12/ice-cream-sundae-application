import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';


class OrderScreen extends StatelessWidget {
   const OrderScreen({Key? key, required this.orders}) : super(key: key);

  final List<GFCard> orders;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home : Scaffold(
        appBar: AppBar(
        title: const Text("Orders"),
            automaticallyImplyLeading: true,
            leading: IconButton(icon:const Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            )

    ),
    body: ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, position) {
        return orders[position];
      })
        ),
    );

  }

}
