import 'package:flutter/material.dart';

import '../data.dart';
import '../screens/add_book.dart';

class BookList extends StatelessWidget {
  final List<Book> books;
  final List<Author> authors;
  final ValueChanged<Book>? onTap;
  final ValueChanged<Book> onBookAdded;

  const BookList({
    required this.books,
    required this.authors,
    this.onTap,
    required this.onBookAdded,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book List'),
      ),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(books[index].title),
          subtitle: Text(books[index].author.name),
          onTap: onTap != null ? () => onTap!(books[index]) : null,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddBookPage(
                authors: authors,
                onBookAdded: (newBook) {
                  onBookAdded(newBook);
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        tooltip: 'Add new book',
      ),
    );
  }
}
