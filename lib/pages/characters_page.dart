import 'package:flutter/material.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Characters Page'),
      ),
      body: const Center(
        child: Text('Welcome to the Characters Page!'),
      ),
    );
  }
}