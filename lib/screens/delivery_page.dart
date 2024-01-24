import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shopping_basket_page.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final basketProvider = Provider.of<BasketProvider>(context);

    return Scaffold(
      body: ListView.builder(
        itemCount: basketProvider.orderHistory.length,
        itemBuilder: (context, index) {
          final order = basketProvider.orderHistory[index];
          return OrderItem(
            orderNumber: 'Замовлення #$index',
            orderDate: 'Дата: ${DateTime.now().toString()}',
            orderDetails: order['items'],
          );
        },
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String orderNumber;
  final String orderDate;
  final Map<String, dynamic> orderDetails;

  const OrderItem(
      {super.key,
      required this.orderNumber,
      required this.orderDate,
      required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(orderNumber),
        subtitle: Text('Дата замовлення: $orderDate'),
        onTap: () {
          _viewOrderDetails(context);
        },
      ),
    );
  }

  void _viewOrderDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Деталі замовлення $orderNumber'),
          content: const Text(
              'Ця сторінка може містити докладну інформацію про ваше замовлення.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрити'),
            ),
          ],
        );
      },
    );
  }
}
