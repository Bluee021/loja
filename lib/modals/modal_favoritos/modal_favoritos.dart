import "package:ecommerce/models/produto/produto.dart";
import "package:ecommerce/widgets/product_favoritos/product_favoritos.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class Favoritos extends StatefulWidget {
  const Favoritos({super.key, required this.cliente});
  final UserCredential cliente;

  @override
  State<Favoritos> createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
      ),
    );
    //   body: Container(
    //     height: MediaQuery.of(context).size.height,
    //     child: ListView.builder(
    //         itemCount: 3,
    //         itemBuilder: (context, index) {
    //           Produto produto = Produto("", 0, "", "");
    //           return ProductFavoritos(
    //             cliente: widget.cliente,
    //             produto: produto,
    //           );
    //         }),
    //   ),
    // );
  }
}
