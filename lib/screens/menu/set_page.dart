import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class SetDetails extends StatelessWidget {
  final List<Map<String, String>> sets = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/01/01/15/31/sushi-balls-5878892_1280.jpg',
      'title': 'Бабл сет',
      'price': '339 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2023/07/07/17/47/sushi-8113165_1280.jpg',
      'title': 'Запечений сет',
      'price': '419 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/06/29/19/57/sushi-2455981_1280.jpg',
      'title': 'Lux сет',
      'price': '499 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/01/22/17/13/sushi-2000239_1280.jpg',
      'title': 'Light сет',
      'price': '329 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/10/16/09/01/sushi-2856547_1280.jpg',
      'title': 'Сет на одного',
      'price': '199 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/04/04/15/07/sushi-5002639_1280.jpg',
      'title': 'Premium сет',
      'price': '849 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/10/16/01/sushi-716458_1280.jpg',
      'title': 'На компанію',
      'price': '699 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/08/10/08/39/sushi-2620063_1280.jpg',
      'title': 'На двох',
      'price': '399 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/01/06/16/46/sushi-1958247_1280.jpg',
      'title': 'Сет багато риби',
      'price': '999 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/04/20/17/21/sushi-2246348_1280.jpg',
      'title': 'Макі сет',
      'price': '199 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/02/28/03/00/food-2104757_1280.jpg',
      'title': 'Нагірі сет',
      'price': '399 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/04/04/03/20/food-2200139_1280.jpg',
      'title': 'Човен сет',
      'price': '549 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/06/24/07/57/sushi-2436928_1280.jpg',
      'title': 'Величезний сет',
      'price': '789 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/07/31/17/14/sushi-6512533_1280.jpg',
      'title': 'Легкий сет',
      'price': '329 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (sets.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildSetItem(
                      context,
                      sets[index * 2]['imageUrl']!,
                      sets[index * 2]['title']!,
                      sets[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded(
                    child: (index * 2 + 1 < sets.length)
                        ? _buildSetItem(
                            context,
                            sets[index * 2 + 1]['imageUrl']!,
                            sets[index * 2 + 1]['title']!,
                            sets[index * 2 + 1]['price']!,
                          )
                        : const SizedBox(), 
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}

Widget _buildSetItem(
    BuildContext context, String imageUrl, String title, String price) {
  var basketProvider = Provider.of<BasketProvider>(context, listen: false);

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
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          'Ціна: $price',
          style: const TextStyle(fontSize: 16),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Map<String, String> item = {'title': title, 'price': price};
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
