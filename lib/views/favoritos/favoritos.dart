import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecommerce/widgets/product_favoritos/product_favoritos.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import "../../models/produto/produto.dart";

class Favoritos extends StatefulWidget {
  const Favoritos({super.key, required this.cliente});
  final UserCredential cliente;
  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  late Stream<List<Produto>> _stream;

  _removeFavoritos(String id, index) async {
    CollectionReference cliente = FirebaseFirestore.instance
        .collection("cliente")
        .doc(widget.cliente.user!.uid)
        .collection("favoritos");
    await cliente.doc(id).delete().then((value) {
      setState(() {
        produtos.removeAt(index);
      });
    });
  }

  List<Produto> produtos = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _stream = (() {
      late final StreamController<List<Produto>> controller;
      List<Produto> produtos = [];

      controller = StreamController<List<Produto>>(
        onListen: () async {
          CollectionReference cliente = FirebaseFirestore.instance
              .collection("cliente")
              .doc(widget.cliente.user!.uid)
              .collection("favoritos");

          await cliente.get().then((value) {
            for (QueryDocumentSnapshot item in value.docs) {
              Produto produto = Produto(item["descricao"], item["preco"] * 1.00,
                  item["categoria"], item.id,
                  nome: item["nome"]);
              produtos.add(produto);
            }
            controller.add(produtos);
          });

          await controller.close();
        },
      );

      return controller.stream;
    })();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
      body: StreamBuilder<List<Produto>>(
          stream: _stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                produtos = snapshot.data!;

                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                      itemCount: produtos.length,
                      itemBuilder: (context, index) {
                        Produto produto = produtos[index];
                        return ProductFavoritos(
                          removeFavoritos: () =>
                              _removeFavoritos(produto.id, index),
                          cliente: widget.cliente,
                          produto: Produto(produto.descricao, produto.preco,
                              produto.categoria, produto.id,
                              nome: produto.nome),
                        );
                      }),
                );
            }
          }),
    );
  }
}
