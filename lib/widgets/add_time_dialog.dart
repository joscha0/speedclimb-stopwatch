import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:speedclimbing/models/time_entry_model.dart';
import 'package:speedclimbing/providers/time_entry_provider.dart';

class AddTimeDialog extends ConsumerStatefulWidget {
  const AddTimeDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTimeDialogState();
}

class _AddTimeDialogState extends ConsumerState<AddTimeDialog> {
  final TextEditingController dateController = TextEditingController(
      text: DateFormat('dd.MM.yyyy').format(DateTime.now()));
  final TextEditingController timeController =
      TextEditingController(text: DateFormat('HH:mm').format(DateTime.now()));
  DateTime date = DateTime.now();

  bool dnf = false;

  final TextEditingController durationSecondsController =
      TextEditingController();
  final TextEditingController durationMillisecondsController =
      TextEditingController();

  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add time'),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Divider(),
          const Text('Date and time'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: dateController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      icon: Icon(
                        Icons.calendar_today,
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101),
                      );

                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('dd.MM.yyyy').format(pickedDate);

                        setState(() {
                          dateController.text = formattedDate;
                          date = DateTime(pickedDate.year, pickedDate.month,
                              pickedDate.day, date.hour, date.minute);
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: TextField(
                    controller: timeController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      icon: Icon(
                        Icons.timer_outlined,
                      ),
                    ),
                    onTap: () async {
                      TimeOfDay? pickedDate = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedDate != null) {
                        final now = DateTime.now();
                        String formattedDate = DateFormat('HH:mm').format(
                            DateTime(now.year, now.month, now.day,
                                pickedDate.hour, pickedDate.minute));

                        setState(() {
                          timeController.text = formattedDate;
                          date = DateTime(date.year, date.month, date.day,
                              pickedDate.hour, pickedDate.minute);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          CheckboxListTile(
            value: dnf,
            onChanged: (value) {
              setState(() {
                dnf = value ?? false;
              });
            },
            title: const Text("DNF (Did not finish)"),
          ),
          const Divider(),
          dnf
              ? Container()
              : Column(children: [
                  const Text('Duration'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: TextField(
                            controller: durationSecondsController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              label: Text("s"),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("."),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: durationMillisecondsController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: const InputDecoration(
                              label: Text("ms"),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          const Divider(),
          const Text('Notes'),
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
          ),
          const Divider(),
        ]),
      ),
      actionsAlignment: MainAxisAlignment.spaceEvenly,
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
              final seconds = int.tryParse(durationSecondsController.text) ?? 0;
              final milliseconds =
                  int.tryParse(durationMillisecondsController.text) ?? 0;
              TimeEntry newEntry = TimeEntry(
                  date: date,
                  duration: milliseconds + seconds * 1000,
                  isDNF: dnf,
                  notes: notesController.text);
              ref.read(timeEntriesProvider.notifier).addTimeEntry(newEntry);
              Navigator.of(context).pop();
            },
            child: const Text("Save")),
      ],
    );
  }
}
