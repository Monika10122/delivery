import 'package:delivery_shop/logic/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_page.dart';

class BasketProvider extends ChangeNotifier {
  List<Map<String, String>> selectedItems = [];
  List<Map<String, dynamic>> orderHistory = [];

  void addToBasket(Map<String, String> item) {
    selectedItems.add(item);
    notifyListeners();
  }

  void removeFromBasket(int index) {
    selectedItems.removeAt(index);
    notifyListeners();
  }

  void placeOrder(String selectedTime, double totalAmount) {
    final orderData = {
      'selectedTime': selectedTime,
      'totalAmount': totalAmount,
      'deliveryCost': totalAmount >= 700 ? 0 : 60,
      'items': selectedItems.toList(),
    };

    orderHistory.add(orderData);
    selectedItems.clear();
    notifyListeners();
  }
}

class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  bool isOrderPageVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer2<BasketProvider, AppThemeProvider>(
        builder: (context, basketProvider, appThemeProvider, _) {
          double totalAmount = 0;

          if (basketProvider.selectedItems.isNotEmpty) {
            totalAmount = basketProvider.selectedItems.map((item) {
              String priceString = item['price'] ?? '0';
              double price = double.tryParse(
                      priceString.replaceAll(RegExp(r'[^0-9]'), '')) ??
                  0;
              return price;
            }).reduce((value, element) => value + element);
          }

          double deliveryCost = totalAmount >= 700 ? 0 : 60;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Visibility(
                  visible: !isOrderPageVisible,
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: basketProvider.selectedItems.length,
                          itemBuilder: (context, index) {
                            final item = basketProvider.selectedItems[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ListTile(
                                title: Text(item['title'] ?? ''),
                                subtitle: Text('Ціна: ${item['price']}'),
                                trailing: IconButton(
                                  icon: const Icon(
                                    Icons.delete_outline_rounded,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    basketProvider.removeFromBasket(index);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text('Сума: $totalAmount грн',
                            style: const TextStyle(fontSize: 25)),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          totalAmount >= 700
                              ? 'Доставка безкоштовна'
                              : 'Доставка: $deliveryCost грн  (Доставка безкоштовна при замовлені на 700 грн)',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isOrderPageVisible = true;
                          });
                        },
                        child: const Text('Оформити замовлення',
                            style: TextStyle(color: Colors.black87)),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isOrderPageVisible,
                  child: OrderPage(
                    totalAmount: totalAmount,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
