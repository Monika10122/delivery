import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class RamenDetails extends StatelessWidget {
  final List<Map<String, String>> ramen = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/04/04/00/36/ramen-2199962_1280.jpg',
      'title': 'Рамен зі свининою',
      'price': '239 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/11/23/15/30/ramen-4647411_1280.jpg',
      'title': 'Томатний рамен',
      'price': '219 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/03/15/10/33/bars-ramen-in-saigon-3227779_1280.jpg',
      'title': 'Рамен з куркою',
      'price': '209 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/11/23/15/26/ramen-4647408_1280.jpg',
      'title': 'Рамен з білою рибою',
      'price': '249 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/03/13/09/05/ramen-3221981_1280.jpg',
      'title': 'Овощний рамен',
      'price': '199 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/09/27/02/36/ramen-6659278_1280.jpg',
      'title': 'Карі рамен',
      'price': '189 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/11/01/05/57/ramen-4593402_1280.jpg',
      'title': 'Соєвий рамен',
      'price': '279 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/09/17/12/25/ramen-5579023_1280.jpg',
      'title': 'Light рамен',
      'price': '149 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/12/20/02/07/miso-ramen-6882175_1280.jpg',
      'title': 'Мисо рамен',
      'price': '199 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/05/13/16/16/noodle-soup-765706_1280.jpg',
      'title': 'Карбонара рамен',
      'price': '319 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2022/05/10/18/50/ramen-7187810_1280.jpg',
      'title': 'Big рамен',
      'price': '379 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/11/23/15/30/ramen-4647411_1280.jpg',
      'title': 'Фірмовий рамен',
      'price': '79 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2022/02/13/07/35/food-7010526_1280.jpg',
      'title': 'Тофу рамен',
      'price': '309 грн',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: (ramen.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildRamenItem(
                      context,
                      ramen[index * 2]['imageUrl']!,
                      ramen[index * 2]['title']!,
                      ramen[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded(
                    child: (index * 2 + 1 < ramen.length)
                        ? _buildRamenItem(
                            context,
                            ramen[index * 2 + 1]['imageUrl']!,
                            ramen[index * 2 + 1]['title']!,
                            ramen[index * 2 + 1]['price']!,
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

Widget _buildRamenItem(
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
