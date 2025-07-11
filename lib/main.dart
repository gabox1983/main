// Proyecto Flutter: Interfaz con Búsqueda y Agregado de Ítems
// Autor: Gabriel Colmenares

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta el banner de DEBUG
      title: 'App de Interfaz y Búsqueda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<String> _items = [
    'Laptops',
    'Cargadores',
    'Teléfonos',
    'Cámaras',
    'Monitores',
    'Teclados',
    'Ratones',
    'Impresoras',
    'Auriculares',
    'Tabletas',
  ];

  String _filter = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addItem() {
    setState(() {
      _items.add('Nuevo Artículo ${_items.length + 1}');
    });
  }

  void _clearSearch() {
    setState(() {
      _filter = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _items
        .where((item) => item.toLowerCase().contains(_filter.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Buscar...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              _filter = value;
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: _clearSearch,
            tooltip: 'Limpiar búsqueda',
          ),
        ],
      ),
      body: filteredItems.isNotEmpty
          ? ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredItems[index]),
                  leading: const Icon(Icons.devices_other_outlined),
                );
              },
            )
          : const Center(
              child: Text(
                'No hay resultados',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addItem,
        label: const Text('Agregar'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
