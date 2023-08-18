import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/models/users/usuario_cliente.dart';
import 'package:ecommerce/views/add_conta/components/input.dart';
import 'package:ecommerce/views/home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdicionarConta extends StatefulWidget {
  const AdicionarConta({super.key});

  @override
  State<AdicionarConta> createState() => _AdicionarContaState();
}

class _AdicionarContaState extends State<AdicionarConta> {
  late TextEditingController controllerEmail;
  late TextEditingController controllerSenha;
  late TextEditingController controllerNome;

  _cadastrarUsuario(UsuarioCliente usuario) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference clientes = firestore.collection("cliente");

    await auth
        .createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha,
    )
        .then((firebaseUser) async {
      await clientes.doc(firebaseUser.user!.uid).set({"nome": usuario.nome});
      await Navigator.push(
        context as BuildContext,
        MaterialPageRoute(
            builder: (context) => Home(
                  user: firebaseUser,
                )),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controllerEmail = TextEditingController();
    controllerSenha = TextEditingController();
    controllerNome = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Cadastre-se",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            Input(
              controller: controllerEmail,
              hintText: 'Email',
              inputType: TextInputType.emailAddress,
            ),
            Input(
              controller: controllerSenha,
              hintText: 'senha',
              ocultar: true,
            ),
            Input(
              controller: controllerNome,
              hintText: 'Nome completo',
            ),
            ElevatedButton(
                onPressed: () async {
                  UsuarioCliente usuarioCliente = UsuarioCliente(
                      controllerEmail.text, controllerSenha.text,
                      nome: controllerNome.text);
                  _cadastrarUsuario(usuarioCliente);
                },
                child: Text('Registrar'))
          ],
        ),
      ),
    );
  }
}
