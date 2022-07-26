import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/application/todoprovider/todo_provider.dart';
import 'package:todo_app/domain/todo-oparations/get_todo.dart';
import 'package:todo_app/presentation/grouppage/show_dialog.dart';
import 'package:todo_app/presentation/widgets/colors.dart';

class Getodo_page extends StatelessWidget {
  const Getodo_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.blue_color,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.go("/home");
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Image(
                height: 60,
                width: 60,
                image: AssetImage("assets/images/note.png")),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Consumer(
                builder: (context, ref, child) {
                  final data = ref.read(todoProvider.notifier).nameofcategory;
                  return Text(
                    data.toString().toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  );
                },
              )),
          Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Consumer(
                builder: (context, ref, child) {
                  final data = ref.watch(todoProvider);
                  return Text(
                    '${data.length} Task',
                    style: const TextStyle(color: Colors.white54, fontSize: 20),
                  );
                },
              )),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: Stack(
            children: [
              Positioned(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Consumer(
                    builder: (context, ref, child) {
                      List<GetTodo> gettododata = ref.watch(todoProvider);
                      return gettododata.length == 0
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: gettododata.length == 0
                                  ? 5
                                  : gettododata.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(gettododata[index].title.toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                              fontFamily: "kanit")),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          gettododata[index].details.toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: Colors.black54,
                                              fontSize: 20,
                                              fontFamily: "kanit")),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              ref
                                                  .read(todoProvider.notifier)
                                                  .deleteTodo(
                                                      gettododata[index]
                                                          .sId
                                                          .toString(),
                                                      ref
                                                          .read(todoProvider
                                                              .notifier)
                                                          .nameofcategory
                                                          .toString(),
                                                      ref);
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Colors.red
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Center(
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      fontFamily: "kanit"),
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Show_dialog(
                                                        id: gettododata[index]
                                                            .sId
                                                            .toString(),
                                                        ref: ref,
                                                        present_category: ref
                                                            .read(todoProvider
                                                                .notifier)
                                                            .nameofcategory);
                                                  });
                                            },
                                            child: Container(
                                              height: 40,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  color: Colors.green
                                                      .withOpacity(0.7),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: const Center(
                                                child: Text(
                                                  "Update",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      fontFamily: "kanit"),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        height: 1,
                                        thickness: 3,
                                      )
                                    ],
                                  ),
                                );
                              });
                    },
                  ),
                ),
              )
            ],
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            context.go("/addtodo");
          }),
    );
  }
}
