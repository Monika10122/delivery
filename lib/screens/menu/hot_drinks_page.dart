import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class HotDrinksDetails extends StatelessWidget {
  final List<Map<String, String>> hotDrinks = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/05/23/15/16/herbal-tea-1410565_1280.jpg',
      'title': 'Травяний чай',
      'price': '49 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/07/02/20/37/cup-829527_1280.jpg',
      'title': 'Ромашковий чай',
      'price': '69 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/05/12/08/29/coffee-2306471_1280.jpg',
      'title': 'Капучино',
      'price': '59 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/05/25/14/29/tea-783352_1280.jpg',
      'title': 'Цитрусовий чай',
      'price': '69 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/01/05/12/tea-cup-2107599_1280.jpg',
      'title': 'Чорний чай',
      'price': '40 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2012/02/23/09/16/coffee-15994_1280.jpg',
      'title': 'Еспресо',
      'price': '49 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/09/04/18/39/coffee-2714970_1280.jpg',
      'title': 'Американо',
      'price': '59 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/09/21/05/57/coffee-5589036_1280.jpg',
      'title': 'Авторська кава',
      'price': '79 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/09/11/10/59/latte-macchiato-3669136_1280.jpg',
      'title': 'Лате',
      'price': '69 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/10/06/11/22/coffee-3727673_1280.jpg',
      'title': 'Макіато',
      'price': '59 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (hotDrinks.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildHotDrinksItem(
                      context,
                      hotDrinks[index * 2]['imageUrl']!,
                      hotDrinks[index * 2]['title']!,
                      hotDrinks[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), // проміжок між карточками
                  Expanded(
                    child: (index * 2 + 1 < hotDrinks.length)
                        ? _buildHotDrinksItem(
                            context,
                            hotDrinks[index * 2 + 1]['imageUrl']!,
                            hotDrinks[index * 2 + 1]['title']!,
                            hotDrinks[index * 2 + 1]['price']!,
                          )
                        : const SizedBox(), // якщо немає другої карточки, вставляємо пустий контейнер
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

Widget _buildHotDrinksItem(
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
                duration: Duration(seconds: 3),
                backgroundColor: Color.fromARGB(255, 208, 191, 255),
                behavior: SnackBarBehavior.floating,
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
