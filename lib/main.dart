import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/home_navigation.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterModelAdapter());
  await Hive.openBox<CharacterModel>('favBox');
  await Hive.openBox('cacheBox');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeNavigation(),
    );
  }
}
