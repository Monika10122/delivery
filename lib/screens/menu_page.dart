import 'package:delivery_shop/logic/app_theme.dart';
import 'package:delivery_shop/screens/menu/cold_drinks_page.dart';
import 'package:delivery_shop/screens/menu/hot_drinks_page.dart';
import 'package:delivery_shop/screens/menu/set_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/current_widget.dart';
import 'menu/pizza_page.dart';
import 'menu/ramen_page.dart';
import 'menu/rol_page.dart';
import 'menu/salad_page.dart';
import 'menu/sashimi_page.dart';
import 'menu/soup_page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppThemeProvider appThemeProvider = AppThemeProvider();
  late CurrentWidgetNotifier currentWidgetNotifier;

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void changeContent(String menuItem) {
    switch (menuItem) {
      case 'Роли':
        currentWidgetNotifier
            .updateWidget(RoleDetails()); // Оновлення вмісту на RoleDetails
        break;
      case 'Сети':
        currentWidgetNotifier.updateWidget(SetDetails());
        break;
      case 'Сашимі':
        currentWidgetNotifier.updateWidget(SashimiDetails());
        break;
      case 'Рамен':
        currentWidgetNotifier.updateWidget(RamenDetails());
        break;
      case 'Піца':
        currentWidgetNotifier.updateWidget(PizzaDetails());
        break;
      case 'Салати':
        currentWidgetNotifier.updateWidget(SaladDetails());
        break;
      case 'Супи':
        currentWidgetNotifier.updateWidget(SoupDetails());
        break;
      case 'Холодні напої':
        currentWidgetNotifier.updateWidget(ColdDrinksDetails());
        break;
      case 'Гарячі напої':
        currentWidgetNotifier.updateWidget(HotDrinksDetails());
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentWidgetNotifier =
          Provider.of<CurrentWidgetNotifier>(context, listen: false);
      currentWidgetNotifier.updateWidget(RoleDetails());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppThemeProvider>(builder: (context, appThemeProvider, _) {
      return Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: Image.asset(
                    'assets/sushi_1.png',
                    height: 50,
                    width: 50,
                  ),
                  title: const Text('Роли'),
                  onTap: () {
                    changeContent('Роли');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: Image.asset(
                    "assets/sushi.png",
                    height: 50,
                    width: 50,
                  ),
                  title: const Text('Сети'),
                  onTap: () {
                    changeContent('Сети');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading: Image.asset(
                    'assets/sashimi.png',
                    height: 50,
                    width: 50,
                  ),
                  title: const Text('Сашимі'),
                  onTap: () {
                    changeContent('Сашимі');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading:
                      Image.asset('assets/ramen.png', height: 50, width: 50),
                  title: const Text('Рамен'),
                  onTap: () {
                    changeContent('Рамен');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading:
                      Image.asset('assets/pizza.png', height: 50, width: 50),
                  title: const Text('Піца'),
                  onTap: () {
                    changeContent('Піца');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading:
                      Image.asset('assets/salad.png', height: 50, width: 50),
                  title: const Text('Салати'),
                  onTap: () {
                    changeContent('Салати');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading:
                      Image.asset('assets/hot-soup.png', height: 50, width: 50),
                  title: const Text('Супи'),
                  onTap: () {
                    changeContent('Супи');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading:
                      Image.asset('assets/coffee.png', height: 50, width: 50),
                  title: const Text('Гарячі напої'),
                  onTap: () {
                    changeContent('Гарячі напої');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListTile(
                  leading:
                      Image.asset('assets/drink.png', height: 50, width: 50),
                  title: const Text('Холодні напої'),
                  onTap: () {
                    changeContent('Холодні напої');
                  },
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Consumer<CurrentWidgetNotifier>(
                    builder: (context, notifier, _) {
                      return notifier.currentWidget;
                    },
                  ),
                ),
              ],
            ),
            // Вищий елемент (кнопка)
            Positioned(
              top: 5,
              left: 5,
              child: Ink(
                decoration: const ShapeDecoration(
                  color: Colors.grey,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: _openDrawer,
                  icon: const Icon(Icons.menu_book_rounded),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
