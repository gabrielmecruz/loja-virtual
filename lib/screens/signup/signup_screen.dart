import 'package:flutter/material.dart';
import 'package:loja_virtual/helpers/validators.dart';
import 'package:loja_virtual/models/user_app.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final UserApp userApp = UserApp();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final UserApp user = UserApp();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cadastro',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(builder: (_, userManager, __) {
              return ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Nome completo'),
                    keyboardType: TextInputType.name,
                    autocorrect: false,
                    validator: (name) {
                      if (name!.isEmpty)
                        return 'Campo obrigatório';
                      else if (name.trim().split(' ').length <= 1)
                        return 'Preencha seu nome completo';
                      return null;
                    },
                    onSaved: (name) => userApp.name = name,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (email) {
                      if (email!.isEmpty)
                        return 'Campo obrigatório';
                      else if (!emailValid(email)) return 'E-mail inválido';
                      return null;
                    },
                    onSaved: (email) => userApp.email = email,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Senha'),
                    autocorrect: false,
                    obscureText: true,
                    validator: (pw) {
                      if (pw!.isEmpty)
                        return 'Campo obrigatório';
                      else if (pw.length < 6) return 'Senha inválida';
                      return null;
                    },
                    onSaved: (pw) => userApp.password = pw,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Repita a senha'),
                    autocorrect: false,
                    obscureText: true,
                    validator: (rpw) {
                      if (rpw!.isEmpty)
                        return 'Campo obrigatório';
                      else if (rpw.length < 6) return 'Senha inválida';
                      return null;
                    },
                    onSaved: (rpw) => userApp.confirmPassword = rpw,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onSurface: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          if (user.password != user.confirmPassword) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Senhas não coincidem!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }
                          userManager.signUp(
                              userApp: userApp,
                              onSuccess: () {
                                Navigator.of(context).pop();
                              },
                              onFail: (e) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text('Falha ao realizar cadastro: $e'),
                                  backgroundColor: Colors.red,
                                ));
                              });
                        }
                      },
                      child: userManager.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
