import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/application/todoprovider/category_provider.dart';
import 'package:todo_app/application/todoprovider/todo_provider.dart';
import 'package:todo_app/domain/todo-oparations/add_todo.dart';
import 'package:todo_app/infrastructure/api/api_handler.dart';
import 'package:todo_app/presentation/widgets/colors.dart';

class Addtodo_page extends HookConsumerWidget {
  const Addtodo_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MMMM d , kk:mm').format(now);
    final radioValue = useState(0);
    final titleController = useTextEditingController();
    final detailsController = useTextEditingController();
    final categoryController = useTextEditingController();
    useEffect(() {
      Future.delayed(const Duration(microseconds: 50), () {
        ref.read(categoryProvider.notifier).getCategory();
      });
    }, []);
    List category = [];
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //nav bar
          Padding(
            padding: const EdgeInsets.only(top: 50, right: 20),
            child: Row(
              children: [
                Expanded(child: Container()),
                const Text(
                  "New task",
                  style: TextStyle(
                      fontFamily: "kanit",
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    context.go("/home");
                  },
                  child: const Icon(
                    Icons.close_sharp,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: titleController,
              style: const TextStyle(
                  fontFamily: "kanit",
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  hintText: "What are you planning",
                  labelText: "Title",
                  labelStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.normal)),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
              controller: detailsController,
              maxLines: 5,
              style: const TextStyle(fontFamily: "kanit", fontSize: 19),
              decoration: const InputDecoration(
                  hintText: "What are you planning",
                  labelText: "Descriptions",
                  labelStyle: TextStyle(fontSize: 25)),
            ),
          ),

          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.notifications_outlined,
                  color: Colors.black54,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  formattedDate,
                  style: const TextStyle(
                      fontFamily: "kanit",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 30),
              child: Row(
                children: [
                  Text(
                    "Category :",
                    style: TextStyle(
                        fontFamily: "kanit",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: Container()),
                  Text(
                    "Add Category",
                    style: TextStyle(
                        fontFamily: "kanit",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Add new category'),
                                content: TextField(
                                  controller: categoryController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter category name",
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel")),
                                  ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(categoryProvider.notifier)
                                            .addCategory(
                                                categoryController.text, ref);
                                      },
                                      child: Text("Update"))
                                ],
                              );
                            });
                      },
                      child:
                          const Icon(Icons.add, size: 30, color: Colors.green))
                ],
              )),

          SizedBox(
            height: 220,
            child: SingleChildScrollView(
              child: Consumer(
                builder: (context, ref, child) {
                  category = ref.watch(categoryProvider);
                  return Column(children: [
                    for (int i = 0; i <category.length; i++)
                      category.length == 0
                          ? const Center(child: CircularProgressIndicator())
                          : ListTile(
                              leading: Text(category[i]==null?"":category[i].toString(),
                                  style: const TextStyle(
                                      fontFamily: "kanit",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold)),
                              trailing: Radio(
                                value: i,
                                groupValue: radioValue.value,
                                onChanged: (Object? value) {
                                  radioValue.value = value as int;
                                },
                              ),
                            )
                  ]);
                },
              ),
            ),
          ),

          Center(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: 300, // <-- match_parent
                height: 50,
                child: Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Appcolor.blue_color),
                        onPressed: () async {
                          final id = await ApiHandler().checkuserlogin();
                          final todo = AddTodo(
                              id: id,
                              title: titleController.text,
                              details: detailsController.text,
                              category: category[radioValue.value]);

                          ref.read(todoProvider.notifier).addTodo(todo, ref);
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ));
                  },
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
