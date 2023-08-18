import 'package:ecommerce/models/users/usuario_cliente.dart';
import 'package:ecommerce/views/add_conta/add_conta.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerSenha;

  _login(UsuarioCliente usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth
          .signInWithEmailAndPassword(
              email: usuario.email.trim(), password: usuario.senha.trim())
          .then((value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => Home(
                      user: value,
                    ))));
      });
    } catch (e) {
      print("firebase erro: " + e.toString());
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerEmail = TextEditingController(text: 'mateus1@gmail.com');
    controllerSenha = TextEditingController(text: '123456');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 100.0),
              child: Text(
                "E-Commerce",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    hintText: "email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: controllerSenha,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "senha",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: ElevatedButton(
                onPressed: () {
                  UsuarioCliente usuarioCliente = UsuarioCliente(
                      controllerEmail.text, controllerSenha.text);
                  _login(usuarioCliente);
                },
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(fixedSize: Size(width, 50)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: TextButton(
                onPressed: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return AdicionarConta();
                      });
                },
                child: Text(
                  "Registrar",
                  style: TextStyle(
                      decoration: TextDecoration.underline, fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(fixedSize: Size(width, 50)),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
