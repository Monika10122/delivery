import 'package:delivery_shop/screens/delivery_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/app_theme.dart';
import '../logic/current_widget.dart';
import '/logic/auth.dart';
import 'action_page.dart';
import 'menu/cold_drinks_page.dart';
import 'menu/hot_drinks_page.dart';
import 'menu/pizza_page.dart';
import 'menu/ramen_page.dart';
import 'menu/rol_page.dart';
import 'menu/salad_page.dart';
import 'menu/sashimi_page.dart';
import 'menu/set_page.dart';
import 'menu/soup_page.dart';
import 'menu_page.dart';
import 'settings_page.dart';
import 'shopping_basket_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  final AppThemeProvider appThemeProvider = AppThemeProvider();
  String appBarTitle = 'Меню';
  final SearchController controller = SearchController();
  late CurrentWidgetNotifier currentWidgetNotifier;

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentWidgetNotifier =
          Provider.of<CurrentWidgetNotifier>(context, listen: false);
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const MenuPage();
      case 1:
        return ActionDetails();
      case 2:
        return const BasketPage();
      case 3:
        return const MyOrdersPage();
      case 4:
        return SettingsPage();
      default:
        return const MenuPage();
    }
  }

  final List<String> menuItems = [
    'Роли',
    'Сети',
    'Сашимі',
    'Рамен',
    'Піца',
    'Салати',
    'Супи',
    'Гарячі напої',
    'Холодні напої',
  ];
  void changeContent(String menuItem) {
    switch (menuItem) {
      case 'Роли':
        currentWidgetNotifier.updateWidget(RoleDetails());
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

  void updateAppBarTitle(int index) {
    switch (index) {
      case 0:
        appBarTitle = 'Меню';
        break;
      case 1:
        appBarTitle = 'Акції';
        break;
      case 2:
        appBarTitle = 'Кошик';
        break;
      case 3:
        appBarTitle = 'Замовлення';
        break;
      case 4:
        appBarTitle = 'Налаштування';
        break;
      default:
        appBarTitle = 'Меню';
        break;
    }
  }

  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppThemeProvider, CurrentWidgetNotifier>(
        builder: (context, appThemeProvider, notifier, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          actions: <Widget>[
            Form(
              key: _formKey,
              child: IconButton(
                icon: const Icon(Icons.call_rounded),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor:
                            const Color.fromARGB(255, 242, 212, 253),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Center(
                              child: Text(
                                'Введіть свій номер і ми вам зателефонуємо!',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                labelText: 'Номер телефону',
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(192, 255, 255, 255),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 190, 173, 253),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                ),
                              ),
                              style: const TextStyle(color: Colors.black),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Поле пусте.';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Ні, дякую',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                const snackBar = SnackBar(
                                  content: Text(
                                    'Чекайте на дзвінок оператора',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  duration: Duration(
                                      seconds:
                                          3), 
                                  backgroundColor: Color.fromARGB(
                                      255, 208, 191, 255), 
                                  behavior: SnackBarBehavior
                                      .floating, 
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Очікуйте',
                              style: TextStyle(color: Colors.black87),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border_rounded),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: const Color.fromARGB(255, 242, 212, 253),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Оцініть наш додаток!'),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              5,
                              (index) => IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  const snackBar = SnackBar(
                                    content: Text(
                                      'Дякуємо за оцінку!',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    duration: Duration(
                                        seconds:
                                            3),
                                    backgroundColor: Color.fromARGB(
                                        255, 208, 191, 255), 
                                    behavior: SnackBarBehavior
                                        .floating, 
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Ні, дякую'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            Row(
              children: <Widget>[
                SearchAnchor(
                  viewSurfaceTintColor:
                      const Color.fromARGB(255, 249, 238, 255),
                  dividerColor: const Color.fromARGB(255, 255, 255, 255),
                  viewBackgroundColor: const Color.fromARGB(255, 249, 238, 255),
                  searchController: controller,
                  builder: (BuildContext context, SearchController controller) {
                    return IconButton(
                      icon: const Icon(
                        Icons.search,
                      ),
                      onPressed: () {
                        controller.openView();
                      },
                    );
                  },
                  suggestionsBuilder:
                      (BuildContext context, SearchController controller) {
                    return menuItems.map((menuItem) {
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          title: Text(menuItem),
                          onTap: () {
                            setState(() {
                              changeContent(
                                  menuItem); 
                              controller
                                  .closeView(menuItem); 
                            });
                          },
                        ),
                      );
                    }).toList();
                  },
                )
              ],
            )
          ],
        ),
        body: _buildPage(currentPageIndex), // Відображення вибраної сторінки
        bottomNavigationBar: NavigationBar(
          indicatorColor: const Color.fromARGB(255, 190, 173, 253),
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              updateAppBarTitle(index);
              if (index == 3) {
                changeContent('Замовлення');
              }
            });
          },
          height: 60,
          destinations: <Widget>[
            NavigationDestination(
              icon: Icon(Icons.menu_book_rounded,
                  color: Colors.black.withOpacity(0.8)),
              label: 'Меню',
            ),
            NavigationDestination(
              icon: Icon(Icons.percent_rounded,
                  color: Colors.black.withOpacity(0.8)),
              label: 'Акції',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_basket_outlined,
                  color: Colors.black.withOpacity(0.8)),
              label: 'Кошик',
            ),
            NavigationDestination(
              icon: Icon(Icons.delivery_dining_outlined,
                  color: Colors.black.withOpacity(0.8)),
              label: 'Замовлення',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings, color: Colors.black.withOpacity(0.8)),
              label: 'Налаштування',
            ),
          ],
        ),
      );
    });
  }
}
