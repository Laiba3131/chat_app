import 'package:chat_app/pages/chatting/controller/provider/chat_provider.dart';
import 'package:chat_app/pages/home_page.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/custom_button.dart';
import '../common/custom_textformfield.dart';
import '../services/auth/auth_service.dart';
import 'chatting/view/chat_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  //  void SignIn() async
  // {

  //   if(passwordController.text != confirmPasswordController.text)
  //   {
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Password do not match")));
  //   }
  //    //get the auth service
  //   final authService=Provider.of<AuthService>(context, listen: false);

  //   try{
  //     await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
  //   } catch(e){

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  //   }

  // }

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match")));
      return;
    }

    // Get the auth service
    final authService = Provider.of<ChatProvider>(context, listen: false);

    try {
      await authService.createUserWithEmailandPassword(
          emailController.text, passwordController.text);
      // Clear the text controllers on successful registration
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      // Optionally, you can navigate to the home page or show a success message.
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

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
              SizedBox(
                height: 50,
              ),
              Icon(
                Icons.message,
                size: 100,
                color: Colors.grey[800],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Lets create an account of you',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                height: 25,
              ),
              CustomTextField(
                controller: emailController,
                hintText: 'Email',
                obsecureText: false,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                obsecureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: confirmPasswordController,
                hintText: 'Confirm Password',
                obsecureText: true,
              ),
              SizedBox(
                height: 25,
              ),
              CustomButton(
                text: 'Register',
                ontap: () {
                  push(context, ChatView());
                  register();
                },
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a member?',
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  InkWell(
                    onTap: () {
                      push(context, LoginPage());
                    },
                    child: Text(
                      'Login now',
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
    ;
  }
}
