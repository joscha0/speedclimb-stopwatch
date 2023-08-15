import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speedclimbing/providers/settings_provider.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  final TextEditingController atMarkTime = TextEditingController();

  @override
  void initState() {
    ref.read(settingsProvider).whenData((value) {
      atMarkTime.text = value.atMarksTime.toString();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: settings.when(
            data: (data) => Column(
                  children: [
                    const Divider(),
                    CheckboxListTile(
                      value: data.readyProcedure,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .setReadyProcedure(value ?? true);
                      },
                      title: const Text("Enable Ready Procedure"),
                    ),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          const Expanded(
                              flex: 2, child: Text("At Mark Time [ms]")),
                          Expanded(
                            child: TextField(
                              controller: TextEditingController()
                                ..text = data.atMarksTime.toString()
                                ..selection = TextSelection.collapsed(
                                    offset: data.atMarksTime.toString().length),
                              onChanged: (value) => ref
                                  .read(settingsProvider.notifier)
                                  .setAtMarksTime(int.tryParse(value) ?? 0),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                hintText: "At Mark Time",
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
                  ],
                ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) {
              return Center(child: Text(error.toString()));
            }));
  }
}
