import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class SashimiDetails extends StatelessWidget {
  final List<Map<String, String>> sashimi = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/08/26/16/47/food-908745_1280.jpg',
      'title': 'Сашимі Light',
      'price': '139 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/08/19/09/30/japan-1604865_1280.jpg',
      'title': 'Mix Сашимі',
      'price': '219 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/12/03/12/06/raw-fish-slice-1879676_1280.jpg',
      'title': 'Чотири види',
      'price': '209 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/29/21/02/salmon-sashimi-2186542_1280.jpg',
      'title': 'Сашимі з лососем',
      'price': '149 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/29/20/59/sashimi-2186530_1280.jpg',
      'title': 'Сашимі з білою рибою',
      'price': '129 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/11/01/08/19/sashimi-1787626_1280.jpg',
      'title': 'Сашимі ікура',
      'price': '169 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/02/03/02/40/sashimi-621864_1280.jpg',
      'title': 'Сашимі з кальмаром',
      'price': '179 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/09/06/09/44/tuna-1648597_1280.jpg',
      'title': 'Сашимі з тунцем',
      'price': '149 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (sashimi.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildSashimiItem(
                      context,
                      sashimi[index * 2]['imageUrl']!,
                      sashimi[index * 2]['title']!,
                      sashimi[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded(
                    child: (index * 2 + 1 < sashimi.length)
                        ? _buildSashimiItem(
                            context,
                            sashimi[index * 2 + 1]['imageUrl']!,
                            sashimi[index * 2 + 1]['title']!,
                            sashimi[index * 2 + 1]['price']!,
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

Widget _buildSashimiItem(
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
                    seconds: 3), // Тривалість вспливаючого повідомлення
                backgroundColor:
                    Color.fromARGB(255, 208, 191, 255), // Колір фону
                behavior: SnackBarBehavior
                    .floating, // Поведінка вспливаючого повідомлення
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
