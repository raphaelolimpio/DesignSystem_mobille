import 'package:develop_design_system/DesignSystem/Components/Buttons/ActionButton/action_button.dart';
import 'package:develop_design_system/DesignSystem/Components/Buttons/ActionButton/action_button_view_model.dart';
import 'package:develop_design_system/DesignSystem/Components/InputField/input_text.dart';
import 'package:develop_design_system/DesignSystem/Components/InputField/input_text_view_model.dart';
import 'package:develop_design_system/DesignSystem/Components/LinkedLabel/linked_label.dart';
import 'package:develop_design_system/DesignSystem/Components/LinkedLabel/linked_label_view_model.dart';
import 'package:develop_design_system/Scenes/Login/login_router.dart';
import 'package:develop_design_system/Scenes/Login/login_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  Map<String, dynamic>? userData;

  @override
  Widget build(BuildContext context) {
    if (userData != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final Map<String, dynamic> dataToPass = userData!;
        setState(() {
          userData = null;
        });
        LoginPageRouter.goToProfilePage(context, dataToPass);
      });
    }

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 32),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/148x148.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 64),
                    StyledInputField.instantiate(
                      viewModel: InputTextViewModel(
                        controller: emailController,
                        placeholder: 'E-mail',
                        password: false,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Esse campo é obrigatório';
                          } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'Somente letras são permitidas!';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    StyledInputField.instantiate(
                      viewModel: InputTextViewModel(
                        controller: passwordController,
                        placeholder: 'Password',
                        password: true,
                        suffixIcon: const Icon(Icons.remove_red_eye),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Esse campo é obrigatório';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        LinkedLabel.instantiate(
                          viewModel: LinkedLabelViewModel(
                            fullText: 'Forgot Password',
                            linkedText: 'Forgot Password',
                            onLinkTap: () {
                              print('Esqueceu a senha?');
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ActionButton.instantiate(
                      viewModel: ActionButtonViewModel(
                        style: ActionButtonStyle.primary,
                        size: ActionButtonSize.large,
                        text: 'Login',
                        isLoading: false,
                        onPressed: () async {
                          if (emailController.text.isEmpty ||
                              passwordController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Preencha todos os campos")),
                            );
                            return;
                          }

                          setState(() {
                            isLoading = true;
                          });

                          try {
                            Map<String, dynamic> fetchedUserData =
                                await LoginService.fetchLogin(
                              emailController.text,
                              passwordController.text,
                            );

                            setState(() {
                              isLoading = false;
                              userData = fetchedUserData;
                            });
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            print(e);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 96),
                    const Text(
                      'Don\'t Have An Account?',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FittedBox(
                      child: ActionButton.instantiate(
                        viewModel: ActionButtonViewModel(
                          style: ActionButtonStyle.primary,
                          size: ActionButtonSize.small,
                          text: 'Sign Up',
                          isLoading: false,
                          onPressed: () async {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
