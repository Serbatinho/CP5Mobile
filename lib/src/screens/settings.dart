import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/link.dart';

import '../auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: const Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  child: SettingsContent(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsContent extends StatelessWidget {
  const SettingsContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Pega o nome do User de BookstoreAuth
    final String? username = BookstoreAuth.of(context).username;

    return Column(
      children: [
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // Exibe o nome de usuario
        if (username != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Bem-vindo, $username',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FilledButton(
            onPressed: () {
              BookstoreAuth.of(context).signOut();
            },
            child: const Text('Sign out'),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Example using the Link widget:'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Link(
            uri: Uri.parse('/books/all/book/0'),
            builder: (context, followLink) => TextButton(
              onPressed: followLink,
              child: const Text('/books/all/book/0'),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Example using GoRouter.of(context).go():'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            child: const Text('/books/all/book/0'),
            onPressed: () {
              GoRouter.of(context).go('/books/all/book/0');
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Displays a dialog on the root Navigator:'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Alert!'),
                content: const Text('The alert description goes here.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Text('Show Dialog'),
          ),
        ),
      ],
    );
  }
}
