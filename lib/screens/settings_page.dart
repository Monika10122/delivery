import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Авторизація'),
              subtitle:
                  const Text('Зареєструйтесь, та не вказуйте свої данні двічі'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pushNamed(context, '/login_page');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Сповіщення'),
              subtitle: const Text('Управління сповіщеннями'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _manageNotifications(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text('Про додаток'),
              subtitle: const Text('Докладна інформація про додаток'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                _viewAppInfo(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _manageNotifications(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Увімкнути сповіщення'),
          content: Switch(
            value: false,
            onChanged: (value) {
              value = true;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрити'),
            ),
          ],
        );
      },
    );
  }

  void _viewAppInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Про додаток'),
          content: const Text(
              'Ця сторінка може містити докладну інформацію про ваш додаток.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Закрити'),
            ),
          ],
        );
      },
    );
  }
}
