import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecommerce/modals/pagamento/modal_pagamento.dart";
import "package:ecommerce/models/produto/produto.dart";
import "package:ecommerce/widgets/product_carrinho/product_carrinho.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class Carrinho extends StatefulWidget {
  const Carrinho({super.key, required this.cliente});
  final UserCredential cliente;
  @override
  State<Carrinho> createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  late Stream<List<Produto>> stream;
  late List<Produto> produtos;

  _finalizarCompra() async {
    showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return ModalPagamento(produtos: produtos);
        });
    // print("produtos :" + produtos.toString());
    // double total = 0;
    // DateTime date = DateTime.now();
    // CollectionReference compra = FirebaseFirestore.instance
    //     .collection("cliente")
    //     .doc(widget.cliente.user!.uid)
    //     .collection("compras")
    //     .doc("${date.day}:${date.month}:${date.year}")
    //     .collection("${date.hour}:${date.minute}:${date.second}");

    // for (Produto produto in produtos) {
    //   await compra.add({
    //     "nome": produto.nome,
    //     "id": produto.id,
    //     "descricao": produto.descricao,
    //     "preco": produto.preco,
    //     "quantidade": produto.quantidade,
    //     "categoria": produto.categoria
    //   }).then((value) => print("compra finalizada!"));
    // }
  }

  _removeCart(String id) async {
    CollectionReference cliente = FirebaseFirestore.instance
        .collection("cliente")
        .doc(widget.cliente.user!.uid)
        .collection("carrinho");
    await cliente
        .doc(id)
        .delete()
        .then((value) => print("Produto deletado do carrinho!"));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    produtos = [];
    stream = (() {
      late final StreamController<List<Produto>> controller;
      List<Produto> produtos = [];
      controller = StreamController<List<Produto>>(
        onListen: () async {
          CollectionReference cliente = FirebaseFirestore.instance
              .collection("cliente")
              .doc(widget.cliente.user!.uid)
              .collection("carrinho");

          await cliente.get().then((value) {
            for (QueryDocumentSnapshot item in value.docs) {
              Produto produto = Produto(
                item["descricao"],
                item["preco"] * 1.00,
                item["categoria"],
                item.id,
                nome: item["nome"],
                quantidade: 1,
              );
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
      ),
      body: StreamBuilder<List<Produto>>(
          stream: stream,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                produtos = snapshot.data!;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        child: ListView.builder(
                            itemCount: produtos.length,
                            itemBuilder: (context, index) {
                              return ProductCarrinho(
                                  produto: produtos[index],
                                  value: produtos[index].quantidade,
                                  func: () {
                                    _removeCart(produtos[index].id);
                                    setState(() {
                                      produtos.removeAt(index);
                                    });
                                  },
                                  onChanged: (valor) {
                                    setState(() {
                                      produtos[index].quantidade =
                                          int.parse(valor);
                                    });
                                  });
                            }),
                      ),
                      ElevatedButton(
                        child: Text("Finalizar compra"),
                        onPressed: _finalizarCompra,
                        style: ElevatedButton.styleFrom(
                            fixedSize: Size(size.width, 50)),
                      ),
                    ],
                  ),
                );
            }
          }),
    );
  }
}
