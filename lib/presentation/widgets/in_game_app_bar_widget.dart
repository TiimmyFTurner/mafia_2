import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/material.dart';
import 'package:mafia_2/applications/state_management/note_provider.dart';

class InGameAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  final String title;

  const InGameAppBar({super.key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  InGameAppBarState createState() => InGameAppBarState();
}

class InGameAppBarState extends ConsumerState<InGameAppBar> {
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      centerTitle: true,
      leading: IconButton(
          icon: const Icon(Icons.edit_note),
          onPressed: () {
            noteController.text = ref.read(noteProvider);

            // Provider.of<Note>(context, listen: false).note;
            showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (builder) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          "یادداشت",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 16, left: 16, bottom: 16),
                            child: TextField(
                              controller: noteController,
                              maxLines: 25,
                              autofocus: true,
                              decoration: const InputDecoration(
                                  hintText: 'متن یاداشت را وارد کنید'),
                              onChanged: (value) {
                                ref.read(noteProvider.notifier).update(value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                });
          }),
      actions: <Widget>[
        IconButton(icon: const Icon(Icons.lock_outline), onPressed: () {}),
        //TODO impelemnt lock page
        // => Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (_) => Lock()))),
        IconButton(
          icon: const Icon(Icons.fiber_new),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("بازی جدید ؟"),
                  actions: <Widget>[
                    TextButton(
                        onPressed: Navigator.of(context).pop,
                        child: const Text("خیر")),
                    TextButton(
                      child: const Text("بله"),
                      onPressed: () {
                        //TODO impelemnt new game logic
                        // Provider.of<RolesNPlayers>(context, listen: false)
                        //     .newGame();
                        // Provider.of<Note>(context, listen: false)
                        //     .clearNote();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
