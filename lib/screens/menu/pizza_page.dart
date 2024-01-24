import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/app_theme.dart';
import '../shopping_basket_page.dart';

class PizzaDetails extends StatelessWidget {
  final List<Map<String, String>> pizza = [
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/11/29/13/02/cheese-1869708_1280.jpg',
      'title': 'Оливкова-грибна піца',
      'price': '159 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/09/30/15/10/plate-2802332_1280.jpg',
      'title': 'Свина піца',
      'price': '219 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/06/08/16/49/pizza-5275191_1280.jpg',
      'title': 'Міні Маргарита',
      'price': '129 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2014/07/08/12/34/pizza-386717_1280.jpg',
      'title': 'Стандартна',
      'price': '199 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/08/06/06/42/pizza-2589569_1280.jpg',
      'title': 'Молодиця',
      'price': '220 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/02/16/07/39/pizza-1202775_1280.jpg',
      'title': 'Салямі',
      'price': '189 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2016/04/21/22/50/pizza-1344720_1280.jpg',
      'title': 'Пепероні',
      'price': '179 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/04/11/03/13/food-3309418_1280.jpg',
      'title': 'Гостра піца',
      'price': '219 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2017/01/22/19/20/pizza-2000614_1280.jpg',
      'title': 'Від шефа',
      'price': '299 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2018/11/15/10/55/pizza-3816968_1280.jpg',
      'title': 'Італійська',
      'price': '209 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2020/06/17/21/46/pizza-5311269_1280.jpg',
      'title': '4 сири',
      'price': '219 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/08/04/10/46/pizza-874530_1280.jpg',
      'title': 'Беконова-сирна',
      'price': '279 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2015/09/09/20/13/pizza-933032_1280.jpg',
      'title': 'Обідня',
      'price': '179 грн',
    },
    {
      'imageUrl':
          'https://cdn.pixabay.com/photo/2019/06/18/11/59/pizza-4282169_1280.jpg',
      'title': '8 сирів',
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
            itemCount: (pizza.length / 2).ceil(),
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  Expanded(
                    child: _buildPizzaItem(
                      context,
                      pizza[index * 2]['imageUrl']!,
                      pizza[index * 2]['title']!,
                      pizza[index * 2]['price']!,
                    ),
                  ),
                  const SizedBox(width: 8), 
                  Expanded(
                    child: (index * 2 + 1 < pizza.length)
                        ? _buildPizzaItem(
                            context,
                            pizza[index * 2 + 1]['imageUrl']!,
                            pizza[index * 2 + 1]['title']!,
                            pizza[index * 2 + 1]['price']!,
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

Widget _buildPizzaItem(
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
                    Color.fromARGB(255, 208, 191, 255), // Колір фону
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
