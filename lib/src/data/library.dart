import 'author.dart';
import 'book.dart';

final libraryInstance = Library()
  ..addBook(
    title: 'Left Hand of Darkness',
    authorName: 'Ursula K. Le Guin',
    isPopular: true,
    isNew: true,
  )
  ..addBook(
    title: 'Too Like the Lightning',
    authorName: 'Ada Palmer',
    isPopular: false,
    isNew: true,
  )
  ..addBook(
    title: 'Kindred',
    authorName: 'Octavia E. Butler',
    isPopular: true,
    isNew: false,
  )
  ..addBook(
    title: 'The Lathe of Heaven',
    authorName: 'Ursula K. Le Guin',
    isPopular: false,
    isNew: false,
  );

class Library {
  final List<Book> allBooks = [];
  final List<Author> allAuthors = [];

  void addBook({
    required String title,
    required String authorName,
    required bool isPopular,
    required bool isNew,
  }) {
    var author = allAuthors.firstWhere(
      (author) => author.name == authorName,
      orElse: () {
        final newAuthor = Author(allAuthors.length, authorName);
        allAuthors.add(newAuthor);
        return newAuthor;
      },
    );

    var book = Book(allBooks.length, title, isPopular, isNew, author);
    author.books.add(book);
    allBooks.add(book);
  }

  Book getBook(String id) {
    return allBooks[int.parse(id)];
  }

  List<Book> get popularBooks => [
        ...allBooks.where((book) => book.isPopular),
      ];

  List<Book> get newBooks => [
        ...allBooks.where((book) => book.isNew),
      ];
}
