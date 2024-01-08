// import 'package:firbase_first_connect1/app/modules/auth/widgets/my_textform_widget.dart';
// import 'package:flutter/material.dart';

// class MyFormsFields extends StatefulWidget {
//   const MyFormsFields({super.key, required this.formkey});

//   final GlobalKey<FormState> formkey;

//   @override
//   State<MyFormsFields> createState() => _MyFormsFieldsState();

// }

// class _MyFormsFieldsState extends State<MyFormsFields> {
//   final

// final TextEditingController emailController = TextEditingController();
// final TextEditingController passwordController = TextEditingController();
// final TextEditingController usernameController = TextEditingController();

// final FocusNode emailNode = FocusNode();
// final FocusNode passwordlNode = FocusNode();
// final FocusNode userNameNode = FocusNode();

// @override
// void dispose(){
// emailController.dispose();
// passwordController.dispose();
// usernameController.dispose();
// emailNode.dispose();
// passwordlNode.dispose();
// userNameNode.dispose();

// }

//   @override
//   Widget build(BuildContext context) {

//     return Form(
//       key: widget.formkey,
//       child: Column(
//         children: [
//           MyTextFormWidget(
//             TextEditingController: emailController,
//             myFocusNode: emailNode,
//             focusNode: focusNode,
//         textInputAction: textInputAction,
//         obscureText: obscureText, // to hide the password
//         validator: validator,
//         onChanged: onChanged,

//           )
//         ],
//       ),
//     );
//   }
// }

// ignore_for_file: unused_element

import 'package:firbase_first_connect1/app/core/extensions/build_context_extensions.dart';
import 'package:firbase_first_connect1/app/modules/auth/domain/helper/auth_validators.dart';
import 'package:firbase_first_connect1/app/modules/auth/widgets/my_textform_widget.dart';
import 'package:flutter/material.dart';

class MyAuthForm extends StatefulWidget {
  const MyAuthForm({
    super.key,
    this.registerFormKey,
  });

  final GlobalKey<FormState>? registerFormKey;

  @override
  State createState() => _MyAuthFormState();
}

class _MyAuthFormState extends State<MyAuthForm> {
  final _authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController userNameController = TextEditingController();
  final FocusNode userNameFocus = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();

    userNameController.dispose();
    userNameFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: widget.registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              MyTextFormWidget(
                controller: emailController,
                obscureText: false,
                focusNode: emailFocusNode,
                validator: (input) {
                  return _authValidators.emailValidator(input);
                },
                prefIcon: const Icon(Icons.email),
                labelText: context.translate.email,
                textInputAction: TextInputAction.next,
                onChanged: null,
              ),
              const SizedBox(
                height: 12,
              ),
              MyTextFormWidget(
                controller: userNameController,
                obscureText: false,
                focusNode: userNameFocus,
                validator: (input) => _authValidators.userNameValidators(input),
                prefIcon: const Icon(Icons.person),
                labelText: context.translate.userName,
                textInputAction: TextInputAction.next,
                onChanged: null,
              ),
              const SizedBox(
                height: 12,
              ),
              MyTextFormWidget(
                controller: passwordController,
                obscureText: false,
                focusNode: passwordFocusNode,
                validator: (input) => _authValidators.passwordVlidator(input),
                prefIcon: const Icon(Icons.password),
                labelText: context.translate.password,
                textInputAction: TextInputAction.done,
                onChanged: null,
                togglePassword: null,
                suffexIcon: Icon(
                  Icons.remove_red_eye_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
