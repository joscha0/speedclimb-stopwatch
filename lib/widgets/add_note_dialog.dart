import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';

class AddNoteDialog extends ConsumerStatefulWidget {
  final TimeEntry currentTime;
  const AddNoteDialog({super.key, required this.currentTime});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNoteDialogState();
}

class _AddNoteDialogState extends ConsumerState<AddNoteDialog> {
  late final TextEditingController notesController;

  @override
  void initState() {
    notesController = TextEditingController(text: widget.currentTime.notes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Note"),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: notesController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                decoration: const InputDecoration(
                  label: Text("Notes"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            )
          ])),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.white),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
            onPressed: () {
              ref
                  .read(timeEntriesProvider.notifier)
                  .updateNote(widget.currentTime, notesController.text);
              Navigator.of(context).pop();
            },
            child: const Text("Save")),
      ],
    );
  }
}
