import "dart:async";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecommerce/models/produto/produto.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flexible_grid_view/flexible_grid_view.dart";
import "package:flutter/material.dart";

import '../../widgets/product_item/product_item_shop.dart';

class Shop extends StatefulWidget {
  const Shop({super.key, required this.user});
  final UserCredential user;
  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  late Stream<List<Produto>> _stream;

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
              .collection("admin")
              .doc("e575LZRj8zZlRijBFuMH")
              .collection("produtos");

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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xff33907C),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                child: TextField(
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                      hintText: "Pesquise um produto",
                      contentPadding: EdgeInsets.all(0),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                      prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.search,
                          color: Color(0xff33907c),
                        ),
                      )),
                ),
              ),
            ),
            Divider(),
            StreamBuilder<List<Produto>>(
                stream: _stream,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<Produto> produtos = snapshot.data!;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: FlexibleGridView(
                            children: List.generate(produtos.length, (index) {
                          return ProductItem(
                            cliente: widget.user,
                            produto: produtos[index],
                          );
                        })),
                      );
                  }
                })
          ],
        ),
      ),
    );
  }
}
