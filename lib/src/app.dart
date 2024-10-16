import 'package:bookstore/src/screens/add_book.dart';
import 'package:bookstore/src/screens/author_details.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth.dart';
import 'data.dart';
import 'screens/authors.dart';
import 'screens/book_details.dart';
import 'screens/scaffold.dart';
import 'screens/settings.dart';
import 'screens/sign_in.dart';
import 'widgets/book_list.dart';
import 'widgets/fade_transition_page.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final booksNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'books shell');

class Bookstore extends StatefulWidget {
  const Bookstore({super.key});

  @override
  State<Bookstore> createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {
  final BookstoreAuth auth = BookstoreAuth();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      builder: (context, child) {
        if (child == null) {
          throw ('No child in .router constructor builder');
        }
        return BookstoreAuthScope(
          notifier: auth,
          child: child,
        );
      },
      routerConfig: GoRouter(
        refreshListenable: auth,
        debugLogDiagnostics: true,
        initialLocation: '/',
        redirect: (context, state) {
          final signedIn = BookstoreAuth.of(context).signedIn;
          if (state.uri.toString() != '/sign-in' && !signedIn) {
            return '/sign-in';
          }
          return null;
        },
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return BookstoreScaffold(
                selectedIndex: _getSelectedIndex(state.uri.path),
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(
                      builder: (context) {
                        return BookList(
                          books: libraryInstance.popularBooks,
                          onTap: (book) {
                            GoRouter.of(context)
                                .go('/books/popular/book/${book.id}');
                          },
                          authors: libraryInstance.allAuthors,
                          onBookAdded: (Book newBook) {
                            setState(() {
                              libraryInstance.addBook(
                                title: newBook.title,
                                authorName: newBook.author.name,
                                isPopular: newBook.isPopular,
                                isNew: newBook.isNew,
                              );
                            });
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/books/all',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(
                      builder: (context) {
                        return BookList(
                          books: libraryInstance.allBooks,
                          onTap: (book) {
                            GoRouter.of(context)
                                .go('/books/all/book/${book.id}');
                          },
                          authors: libraryInstance.allAuthors,
                          onBookAdded: (Book newBook) {
                            setState(() {
                              libraryInstance.addBook(
                                title: newBook.title,
                                authorName: newBook.author.name,
                                isPopular: newBook.isPopular,
                                isNew: newBook.isNew,
                              );
                            });
                          },
                        );
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'book/:bookId',
                    parentNavigatorKey: appShellNavigatorKey,
                    builder: (context, state) {
                      return BookDetailsScreen(
                        book: libraryInstance
                            .getBook(state.pathParameters['bookId'] ?? ''),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/add-book',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: AddBookPage(
                      onBookAdded: (Book newBook) {
                        setState(() {
                          libraryInstance.addBook(
                            title: newBook.title,
                            authorName: newBook.author.name,
                            isPopular: newBook.isPopular,
                            isNew: newBook.isNew,
                          );
                        });
                        GoRouter.of(context).go('/books/all');
                      },
                    ),
                  );
                },
              ),
              GoRoute(
                path: '/books/popular',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(
                      builder: (context) {
                        return BookList(
                          books: libraryInstance.popularBooks,
                          onTap: (book) {
                            GoRouter.of(context)
                                .go('/books/popular/book/${book.id}');
                          },
                          authors: libraryInstance.allAuthors,
                          onBookAdded: (Book newBook) {
                            setState(() {
                              libraryInstance.addBook(
                                title: newBook.title,
                                authorName: newBook.author.name,
                                isPopular: newBook.isPopular,
                                isNew: newBook.isNew,
                              );
                            });
                          },
                        );
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'book/:bookId',
                    parentNavigatorKey: appShellNavigatorKey,
                    builder: (context, state) {
                      return BookDetailsScreen(
                        book: libraryInstance
                            .getBook(state.pathParameters['bookId'] ?? ''),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/authors',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: AuthorsScreen(
                      onTap: (author) {
                        GoRouter.of(context).go('/authors/author/${author.id}');
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'author/:authorId',
                    builder: (context, state) {
                      final author = libraryInstance.allAuthors.firstWhere(
                        (author) =>
                            author.id ==
                            int.parse(state.pathParameters['authorId']!),
                      );
                      return Builder(builder: (context) {
                        return AuthorDetailsScreen(
                          author: author,
                          onBookTapped: (book) {
                            GoRouter.of(context)
                                .go('/books/all/book/${book.id}');
                          },
                        );
                      });
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const SettingsScreen(),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/sign-in',
            builder: (context, state) {
              return Builder(
                builder: (context) {
                  return SignInScreen(
                    onSignIn: (value) async {
                      final router = GoRouter.of(context);
                      await BookstoreAuth.of(context)
                          .signIn(value.username, value.password);
                      router.go('/books/popular');
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String path) {
    if (path.startsWith('/books')) {
      return 0;
    } else if (path.startsWith('/authors')) {
      return 1;
    } else if (path.startsWith('/settings')) {
      return 2;
    }
    return 0;
  }
}
