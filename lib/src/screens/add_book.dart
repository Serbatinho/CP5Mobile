import 'package:flutter/material.dart';

import '../data.dart';

class AddBookPage extends StatefulWidget {
  final ValueChanged<Book> onBookAdded;

  const AddBookPage({
    required this.onBookAdded,
    super.key,
  });

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();

  Author? _selectedAuthor;

  // Lista de autores definida diretamente dentro da página
  final List<Author> _authors = [
    Author(1, 'Ursula K. Le Guin'),
    Author(2, 'Ada Palmer'),
    Author(3, 'Octavia E. Butler'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Novo Livro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título do Livro',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _yearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Ano de Publicação',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _genreController,
              decoration: const InputDecoration(
                labelText: 'Gênero',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<Author>(
              decoration: const InputDecoration(
                labelText: 'Selecione o Autor',
                border: OutlineInputBorder(),
              ),
              value: _selectedAuthor,
              items: _authors.map((author) {
                return DropdownMenuItem<Author>(
                  value: author,
                  child: Text(author.name),
                );
              }).toList(),
              onChanged: (Author? newValue) {
                setState(() {
                  _selectedAuthor = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addBook,
              child: const Text('Adicionar Livro'),
            ),
          ],
        ),
      ),
    );
  }

  void _addBook() {
    final String title = _titleController.text;
    final String genre = _genreController.text;
    final int? year = int.tryParse(_yearController.text);

    if (title.isEmpty ||
        _selectedAuthor == null ||
        genre.isEmpty ||
        year == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Todos os campos são obrigatórios')),
      );
      return;
    }

    final Book newBook = Book(
      libraryInstance.allBooks.length,
      title,
      false,
      true,
      _selectedAuthor!,
    );

    widget.onBookAdded(newBook);

    Navigator.pop(context);
  }
}
