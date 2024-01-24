import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class SaladDetails extends StatelessWidget {
  final List<Map<String, String>> salads = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/05/11/19/44/fresh-fruits-2305192_1280.jpg',
      'title': 'Фруктовий',
      'price': '139 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2021/01/10/04/37/salad-5904093_1280.jpg',
      'title': 'Греческий',
      'price': '149 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2022/06/07/20/58/salad-7249259_1280.jpg',
      'title': 'Азійський з куркою',
      'price': '209 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/02/01/06/13/vegan-4809593_1280.jpg',
      'title': 'Вегетаріанський',
      'price': '159 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/05/31/13/59/salad-791891_1280.jpg',
      'title': 'Свіжі овочі',
      'price': '140 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/10/31/18/23/salad-1786327_1280.jpg',
      'title': 'Салат з грушею',
      'price': '129 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/04/07/07/51/papaya-salad-710613_1280.jpg',
      'title': 'Пряний салат',
      'price': '79 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/04/13/22/50/salad-2228890_1280.jpg',
      'title': 'Весняний',
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
            itemCount: (salads.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildSaladItem(
                      context,
                      salads[index * 2]['imageUrl']!,
                      salads[index * 2]['title']!,
                      salads[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded(
                    child: (index * 2 + 1 < salads.length)
                        ? _buildSaladItem(
                            context,
                            salads[index * 2 + 1]['imageUrl']!,
                            salads[index * 2 + 1]['title']!,
                            salads[index * 2 + 1]['price']!,
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

Widget _buildSaladItem(
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
