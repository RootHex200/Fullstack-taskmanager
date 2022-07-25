import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app/application/todoprovider/category_provider.dart';
import 'package:todo_app/application/todoprovider/todo_provider.dart';

class Home_page extends HookConsumerWidget {
  const Home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(microseconds: 50), () {
        ref.read(categoryProvider.notifier).getCategory();
      });
    }, []);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(left: 20, top: 40),
              child: Icon(
                Icons.menu,
                size: 30,
              )),
          const SizedBox(
            height: 20,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Lists",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    fontFamily: "kanit"),
              )),
          Expanded(child: Consumer(
            builder: (context, ref, child) {
              final data = ref.watch(categoryProvider);
              return data.length == 0
                  ? const Center(child: CircularProgressIndicator())
                  : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1.1),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ref.read(todoProvider.notifier).getCategoryData(data[index]);
                            context.go("/category-todo");
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      offset: const Offset(0, 3),
                                      blurRadius: 7.0,
                                      spreadRadius: 3.0)
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: const Image(
                                      height: 60,
                                      width: 60,
                                      image:
                                          AssetImage("assets/images/note.png")),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text(
                                      data[index].toString(),
                                      style: const TextStyle(
                                          fontFamily: "kanit",
                                          fontSize: 25,
                                          fontWeight: FontWeight.w800),
                                    )),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "Toatal task check",
                                      style: TextStyle(
                                          fontFamily: "kanit",
                                          fontSize: 20,
                                          color: Colors.black54),
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () {
            
          }),
    );
  }
}
