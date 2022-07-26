import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/application/authprovider/auth_provider.dart';
import 'package:todo_app/domain/userdata/auth_data.dart';
import 'package:todo_app/infrastructure/api/api_handler.dart';
import 'package:todo_app/presentation/widgets/colors.dart';

class Login_page extends HookWidget {
  const Login_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = useTextEditingController();
    final paswordController = useTextEditingController();
    check_user() async {
      final data = await ApiHandler().checkuserlogin();
      print(data.runtimeType);
      if (data != null) {
        context.go("/home");
      }
    }

    useEffect(() {
      check_user();
    }, []);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50),
              child: Center(
                  child: InkWell(
                onTap: () async {},
                child: const Text(
                  "SIGN IN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "kanit",
                  ),
                ),
              )),
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
              child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Required";
                          } else if (value?.indexOf("@") == -1) {
                            return "Enter email address @ require";
                          }
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "kanit",
                        ),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person_add),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelText: "Enter Email",
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontFamily: "kanit",
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == "") {
                            return "Required";
                          } else if (value!.length < 6) {
                            return "Password should be atleast 6 characters";
                          } else if (value.length > 15) {
                            return "Password should not be greater than 15 characters";
                          } else {
                            return null;
                          }
                        },
                        controller: paswordController,
                        keyboardType: TextInputType.visiblePassword,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "kanit",
                        ),
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                )),
                            labelText: "Enter Password",
                            labelStyle: const TextStyle(
                              color: Colors.black54,
                              fontSize: 20,
                              fontFamily: "kanit",
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer(
              builder: (context, ref, child) {
                return InkWell(
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      final authdata = AuthData(
                          email: emailController.text,
                          password: paswordController.text,
                          context: context);

                      ref.read(authProvider.notifier).signin(authdata);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.maxFinite,
                    margin: const EdgeInsets.only(left: 30, right: 30),
                    decoration: BoxDecoration(
                      color: Appcolor.blue_color,
                    ),
                    child: const Center(
                        child: Text(
                      "Sing up",
                      style: TextStyle(fontSize: 23),
                    )),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                      onTap: () {
                        context.go("/registration");
                      },
                      child: const Text(
                        "Registrations now?",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
