import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_characters/models/character_model.dart';
import 'package:rick_and_morty_characters/widgets/my_listview_widgets/my_listview_widget.dart';

class SearchInfoWidget extends StatelessWidget {
  const SearchInfoWidget({
    super.key,
    required this.isLoading,
    required this.hasResults,
    required this.characters,
    required this.controller,
    required this.box,
    required this.performSearch,
    required this.startNewSearch,
  });

  final bool isLoading;
  final bool hasResults;
  final List<CharacterModel> characters;
  final TextEditingController controller;
  final Box box;
  final Future<void> Function(String) performSearch;
  final void Function() startNewSearch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading && characters.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black87),
            )
          : !hasResults && characters.isEmpty
          ? const Center(
              child: Text('No results found.', textAlign: TextAlign.center),
            )
          : characters.isEmpty
          ? ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                if (box.isEmpty) {
                  return const Center(child: Text("No search history"));
                }
                List reversedList = box.values.toList().reversed.toList();
                return ListView.builder(
                  itemCount: reversedList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(reversedList[index]),
                      leading: const Icon(Icons.history),
                      trailing: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          box.deleteAt(reversedList.length - 1 - index);
                        },
                      ),
                      onTap: () {
                        controller.text = reversedList[index];
                        startNewSearch();
                      },
                    );
                  },
                );
              },
            )
          : NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification.metrics.pixels >=
                        notification.metrics.maxScrollExtent - 200 &&
                    !isLoading &&
                    hasResults) {
                  performSearch(controller.text);
                }
                return false;
              },
              child: MyListviewWidget(
                characters: characters,
                isLoading: isLoading,
                hasMore: hasResults,
              ),
            ),
    );
  }
}
