import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../controller/simple_ui_controller.dart';
import '../views/login_view.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  SimpleUIController simpleUIController = Get.put(SimpleUIController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return _buildLargeScreen(size, simpleUIController, theme);
              } else {
                return _buildSmallScreen(size, simpleUIController, theme);
              }
            },
          )),
    );
  }

  /// For large screens
  Widget _buildLargeScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              width: double.maxFinite,
              height: double.infinity,
              color: Colors.black38,
              child: Center(
                child: Text(
                  "> 600",
                  style: kLoginTitleStyle(size),
                ),
              ),
            )),
        SizedBox(width: size.width * 0.06),
        Expanded(
          flex: 2,
          child: _buildMainBody(size, simpleUIController, theme),
        ),
      ],
    );
  }

  /// For Small screens
  Widget _buildSmallScreen(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return SafeArea(child: _buildMainBody(size, simpleUIController, theme));
  }

  /// Main Body
  Widget _buildMainBody(
      Size size, SimpleUIController simpleUIController, ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: size.width > 600
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          size.width > 600
              ? Container()
              : Container(
                  width: double.maxFinite,
                  height: size.height * 0.15,
                  color: Colors.black38,
                  child: Center(
                    child: Text(
                      "< 600",
                      style: kLoginTitleStyle(size),
                    ),
                  ),
                ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Text(
            'Conecte-se',
            textAlign: TextAlign.center,
            style: kLoginTitleStyle(size),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Criar uma conta',
              style: kLoginSubtitleStyle(size),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// username
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      hintText: 'Nome de usuário',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),

                    controller: nameController,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite o nome de usuário';
                      } else if (value.length < 4) {
                        return 'Digite pelo menos 4 caracteres';
                      } else if (value.length > 13) {
                        return 'Caractere máximo é 13';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// Gmail
                  TextFormField(
                    style: kTextFormFieldStyle(),
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_rounded),
                      hintText: 'exemplo@gmail.com',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite um e-mail';
                      } else if (!value.endsWith('@gmail.com')) {
                        return 'O email deve conter @gmail.com';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// password
                  Obx(
                    () => TextFormField(
                      style: kTextFormFieldStyle(),
                      controller: passwordController,
                      obscureText: simpleUIController.isObscure.value,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_open),
                        suffixIcon: IconButton(
                          icon: Icon(
                            simpleUIController.isObscure.value
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            simpleUIController.isObscureActive();
                          },
                        ),
                        hintText: 'Senha',
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, digite uma senha';
                        } else if (value.length < 6) {
                          return 'Digite pelo menos 6 caracteres';
                        } else if (value.length > 13) {
                          return 'Caractere máximo é 13';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Criar uma conta significa que você concorda com nossos Termos de Serviço e nossa Política de Privacidade',
                    style: kLoginTermsAndPrivacyStyle(size),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  /// SignUp Button
                  signUpButton(theme),
                  SizedBox(
                    height: size.height * 0.03,
                  ),

                  /// Navigate To Login Screen
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const LoginView()));
                      nameController.clear();
                      emailController.clear();
                      passwordController.clear();
                      _formKey.currentState?.reset();

                      simpleUIController.isObscure.value = true;
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Já tem uma conta?',
                        style: kHaveAnAccountStyle(size),
                        children: [
                          TextSpan(
                              text: " Entrar",
                              style: kLoginOrSignUpTextStyle(size)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SignUp Button
  Widget signUpButton(ThemeData theme) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0XFF070B6B)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
        },
        child: const Text('Cadastre-se'),
      ),
    );
  }
}
