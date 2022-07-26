import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/domain/userdata/update_data.dart';

import '../../application/todoprovider/todo_provider.dart';

class Show_dialog extends HookWidget {
  final String id;
  final WidgetRef ref;
  final String present_category;
  const Show_dialog(
      {Key? key,
      required this.id,
      required this.ref,
      required this.present_category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = useTextEditingController();
    final details = useTextEditingController();
    final category = useTextEditingController();
    return AlertDialog(
      title: const Center(child: Text("Update sections")),
      content: Container(
        height: 200,
        child: Column(
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(hintText: "Enter titile"),
            ),
            TextField(
              controller: details,
              maxLines: 2,
              decoration: const InputDecoration(hintText: "Enter detials"),
            ),
            TextField(
              controller: category,
              decoration: const InputDecoration(hintText: "Enter Category"),
            )
          ],
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel")),
        ElevatedButton(
            onPressed: () {
              final update = UpdataData(
                  id: id.toString(),
                  title: title.text.toString(),
                  details: details.text.toString(),
                  category: category.text.toLowerCase(),
                  present_category: present_category
                  );
              ref.read(todoProvider.notifier).updateTodo(update, ref);
              Navigator.of(context).pop();
            },
            child: const Text("Update"))
      ],
    );
  }
}
