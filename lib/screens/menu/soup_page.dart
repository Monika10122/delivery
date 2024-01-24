import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class SoupDetails extends StatelessWidget {
  final List<Map<String, String>> soup = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/09/27/09/59/pumpkin-soup-4508015_1280.jpg',
      'title': 'Гарбузовий суп',
      'price': '159 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/17/17/33/potato-soup-2152254_1280.jpg',
      'title': 'Картопляний суп',
      'price': '119 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2014/12/16/23/45/soup-570922_1280.jpg',
      'title': 'Крем суп',
      'price': '219 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/06/01/21/40/soup-1429793_1280.jpg',
      'title': 'Томатний суп',
      'price': '209 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/05/02/01/04/miso-soup-749368_1280.jpg',
      'title': 'Суп із соєвих бобів',
      'price': '120 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/01/01/17/57/fish-soup-3054627_1280.jpg',
      'title': 'Уха',
      'price': '209 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/09/25/18/22/pea-soup-2786133_1280.jpg',
      'title': 'Гороховий суп',
      'price': '179 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (soup.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildSoupItem(
                      context,
                      soup[index * 2]['imageUrl']!,
                      soup[index * 2]['title']!,
                      soup[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded(
                    child: (index * 2 + 1 < soup.length)
                        ? _buildSoupItem(
                            context,
                            soup[index * 2 + 1]['imageUrl']!,
                            soup[index * 2 + 1]['title']!,
                            soup[index * 2 + 1]['price']!,
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

Widget _buildSoupItem(
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
