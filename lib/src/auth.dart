import 'package:flutter/widgets.dart';

/// A mock authentication service
class BookstoreAuth extends ChangeNotifier {
  bool _signedIn = false;
  String? _username;
  // Variavel para armazenar o user

  bool get signedIn => _signedIn;
  String? get username => _username;

  Future<void> signOut() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _signedIn = false;
    _username = null;
    notifyListeners();
  }

  Future<bool> signIn(String username, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));

    _signedIn = true;
    _username = username; // Armazenando o user
    notifyListeners();
    return _signedIn;
  }

  @override
  bool operator ==(Object other) =>
      other is BookstoreAuth && other._signedIn == _signedIn;

  @override
  int get hashCode => _signedIn.hashCode;

  static BookstoreAuth of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<BookstoreAuthScope>()!
      .notifier!;
}

class BookstoreAuthScope extends InheritedNotifier<BookstoreAuth> {
  const BookstoreAuthScope({
    required super.notifier,
    required super.child,
    super.key,
  });
}
