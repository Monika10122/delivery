import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import 'shopping_basket_page.dart';

class ActionDetails extends StatelessWidget {
  final List<Map<String, String>> action = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/06/29/19/57/sushi-2455981_1280.jpg',
      'title': 'Сет від шефа',
      'price': '539 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/08/13/13/food-712665_1280.jpg',
      'title': 'Лосось теріякі',
      'price': '319 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/08/07/21/53/sushi-2608281_1280.jpg',
      'title': 'Рол авокадо-креветка',
      'price': '189 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/11/00/52/sushi-2134135_1280.jpg',
      'title': 'Рибна закуска',
      'price': '319 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/06/04/03/42/sushi-2370273_1280.jpg',
      'title': 'Запечений крем-сир',
      'price': '120 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/03/23/10/27/sushi-685912_1280.jpg',
      'title': 'Рол з тунцем',
      'price': '189 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/05/19/19/42/japan-4214979_1280.jpg',
      'title': 'Сніданок',
      'price': '279 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/02/02/07/43/sushi-5973007_1280.jpg',
      'title': 'Запечений макі',
      'price': '149 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/01/06/19/31/japanese-sushi-4746059_1280.jpg',
      'title': 'Червоний дракон',
      'price': '159 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(
      builder: (context, appThemeProvider, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: (action.length / 2).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildActionItem(
                        context,
                        action[index * 2]['imageUrl']!,
                        action[index * 2]['title']!,
                        action[index * 2]['price']!,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: (index * 2 + 1 < action.length)
                          ? _buildActionItem(
                              context,
                              action[index * 2 + 1]['imageUrl']!,
                              action[index * 2 + 1]['title']!,
                              action[index * 2 + 1]['price']!,
                            )
                          : const SizedBox(),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionItem(
      BuildContext context, String imageUrl, String title, String price) {
    var basketProvider = Provider.of<BasketProvider>(context, listen: false);
    double originalPrice = double.parse(price.replaceAll(' грн', '').trim());
    double discountedPrice = originalPrice - (originalPrice * 0.2);
    int roundedDiscountedPrice = discountedPrice.round();

    return Card(
      color: const Color.fromARGB(255, 244, 237, 253),
      elevation: 3,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrl,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              decoration: TextDecoration.lineThrough,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'Акційна ціна: $roundedDiscountedPrice грн',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                Map<String, String> item = {
                  'title': title,
                  'price': ' ${roundedDiscountedPrice.toString()} грн',
                };
                basketProvider.addToBasket(item);
                const snackBar = SnackBar(
                  content: Text(
                    'Додано',
                    style: TextStyle(color: Colors.black),
                  ),
                  duration: Duration(
                      seconds: 3), 
                  backgroundColor:
                      Color.fromARGB(255, 208, 191, 255), 
                  behavior: SnackBarBehavior
                      .floating, 
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                'Додати',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
