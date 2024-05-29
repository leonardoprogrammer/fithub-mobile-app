import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:fithub/panel_page.dart';
import 'package:fithub/register_page.dart';
import 'package:fithub/password_reset_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: Image.asset('assets/images/logo-fithub.png'),
                ),
                const SizedBox(height: 20),
                const Text('Acesse sua conta', style: TextStyle(fontSize: 24)),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-mail',
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Senha',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PasswordResetPage()),
                      );
                    },
                    child: const Text('Esqueceu sua senha?'),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Requisição de Login na API
                    String urlAPI =
                        'http://100.96.1.2:8081/fithub-api/auth/login';
                    final response = await http.post(
                      Uri.parse(urlAPI),
                      headers: <String, String>{
                        'Content-Type': 'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, String>{
                        'email': emailController.text,
                        'password': passwordController.text,
                      }),
                    );

                    if (response.statusCode == 200) {
                      // Se o servidor retornar uma resposta OK, parse a resposta.
                      Map<String, dynamic> responseBody =
                          jsonDecode(response.body);
                      String token = responseBody['token'];

                      // Armazena o token para futuras requisições na API
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setString('token', token);

                      // Armazena o status de login do usuário
                      await prefs.setBool('isLoggedIn', true);

                      // Redireciona para o painel
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PanelPage()),
                      );
                    } else {
                      // Se a resposta não for OK, lance uma exceção.
                      throw Exception('Falha ao fazer login');
                    }
                  },
                  child: const Text('Entrar'),
                ),
                ElevatedButton(
                  child: const Text('Criar conta'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}