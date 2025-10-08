import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star),
            SizedBox(width: 8.0),
            Text("Favorites"),
          ],
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Favorites Page Content')),
    );
  }
}