import 'package:delivery_shop/screens/shopping_basket_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';

class ColdDrinksDetails extends StatelessWidget {
  final List<Map<String, String>> coldDrinks = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2013/02/21/19/06/drink-84533_1280.jpg',
      'title': 'Маргарита',
      'price': '139 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/02/23/19/23/smoothies-3176371_1280.jpg',
      'title': 'Малиновий смузі',
      'price': '119 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/08/03/21/48/drinks-2578446_1280.jpg',
      'title': 'Лимонад',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/10/22/20/34/wines-1761613_1280.jpg',
      'title': 'Вино',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/05/18/09/28/blueberries-4211525_1280.jpg',
      'title': 'Чорничний смузі',
      'price': '120 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/09/03/01/03/bottles-1640819_1280.jpg',
      'title': 'Фірмові наливки',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/05/08/13/29/drink-4188629_1280.jpg',
      'title': 'Біла лагуна',
      'price': '179 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2023/06/20/10/06/cocktail-8076619_1280.jpg',
      'title': 'Маліфісента',
      'price': '149 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/11/19/13/53/margarita-1839361_1280.jpg',
      'title': 'Голуба лагуна',
      'price': '199 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/01/11/11/02/cocktail-1971488_1280.jpg',
      'title': 'Мохіто',
      'price': '109 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (coldDrinks.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildColdDrinksItem(
                      context,
                      coldDrinks[index * 2]['imageUrl']!,
                      coldDrinks[index * 2]['title']!,
                      coldDrinks[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: (index * 2 + 1 < coldDrinks.length)
                        ? _buildColdDrinksItem(
                            context,
                            coldDrinks[index * 2 + 1]['imageUrl']!,
                            coldDrinks[index * 2 + 1]['title']!,
                            coldDrinks[index * 2 + 1]['price']!,
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

Widget _buildColdDrinksItem(
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
