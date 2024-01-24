import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class RoleDetails extends StatelessWidget {
  final List<Map<String, String>> rolls = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/08/13/14/pizza-712667_1280.jpg',
      'title': 'Піцца рол',
      'price': '139 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/29/20/58/california-roll-2186520_1280.jpg',
      'title': 'Рол Каліфорнія',
      'price': '119 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/07/28/15/59/rolls-3568356_1280.jpg',
      'title': 'Рол Бамбук',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/10/15/11/41/sushi-2853382_1280.jpg',
      'title': 'Філадельфія рол',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/07/26/11/48/sushi-2541472_1280.jpg',
      'title': 'Зелений дракон',
      'price': '120 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2014/01/17/09/00/sushi-246820_1280.jpg',
      'title': 'Запечений рол',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/08/03/08/33/food-3581341_1280.jpg',
      'title': 'Макі з креветкою',
      'price': '79 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/05/26/18/52/nagano-3432005_1280.jpg',
      'title': 'Нагано рол',
      'price': '149 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/03/02/20/53/sushi-2112350_1280.jpg',
      'title': 'Вегетаріанський рол',
      'price': '99 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/05/01/09/56/sushi-748139_1280.jpg',
      'title': 'Фірмовий тайбей',
      'price': '109 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/05/26/18/56/sushi-3432023_1280.jpg',
      'title': 'Рол з угрем',
      'price': '119 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/10/15/59/maki-716432_1280.jpg',
      'title': 'Макі з огірком',
      'price': '79 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/06/01/12/39/sushi-2363418_1280.jpg',
      'title': 'Макі з лососем',
      'price': '79 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/10/15/58/salmon-716430_1280.jpg',
      'title': 'Нігірі з тунцем',
      'price': '109 грн',
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
              itemCount: (rolls.length / 2).ceil(),
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Expanded(
                      child: _buildRollItem(
                        context,
                        rolls[index * 2]['imageUrl']!,
                        rolls[index * 2]['title']!,
                        rolls[index * 2]['price']!,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: (index * 2 + 1 < rolls.length)
                          ? _buildRollItem(
                              context,
                              rolls[index * 2 + 1]['imageUrl']!,
                              rolls[index * 2 + 1]['title']!,
                              rolls[index * 2 + 1]['price']!,
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

  Widget _buildRollItem(
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
}
