import 'package:chat_app/pages/chatting/controller/provider/chat_provider.dart';
import 'package:chat_app/pages/chatting/view/chat_view.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/custom_button.dart';
import '../common/custom_textformfield.dart';
import '../utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // ignore: non_constant_identifier_names
  void SignIn() async {
    //get the auth service
    final authService = Provider.of<ChatProvider>(context, listen: false);

    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Icon(
                Icons.message,
                size: 100,
                color: Colors.grey[800],
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                'Welcome backyou have been missed!',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                obsecureText: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obsecureText: true,
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: 'Sign in',
                ontap: () {
                  push(context, const ChatView());
                  SignIn();
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member?',
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {
                      push(context, const RegisterPage());
                    },
                    child: const Text(
                      'Register now',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
