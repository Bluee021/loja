import "package:ecommerce/constants/fonts.dart";
import "package:ecommerce/modals/product_details/modal_product_details.dart";
import "package:ecommerce/models/produto/produto.dart";
import "package:ecommerce/models/utils/convert.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_core/firebase_core.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key, required this.cliente, required this.produto});
  final UserCredential cliente;
  final Produto produto;
  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  _addCarrinho() async {
    Produto produto = widget.produto;
    DocumentReference cliente = FirebaseFirestore.instance
        .collection("cliente")
        .doc(widget.cliente.user!.uid)
        .collection("carrinho")
        .doc(produto.id);
    await cliente.set({
      "nome": produto.nome,
      "preco": produto.preco,
      "descricao": produto.descricao,
      "categoria": produto.categoria
    }).then((value) {
      print("Produto adicionado ao carrinho");
    });
  }

  @override
  Widget build(BuildContext context) {
    Produto produto = widget.produto;
    return Card(
      margin: EdgeInsets.only(left: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(
          Icons.photo_camera_front,
          size: 100,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(
            produto.nome,
            style: styleTiltleItem,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                Convert.convertReal(produto.preco),
                style: stylePrecoItem,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                    onPressed: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return ProductDetails(
                              cliente: widget.cliente,
                              produto: produto,
                            );
                          });
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0),
                  child: IconButton(
                    onPressed: _addCarrinho,
                    icon: FaIcon(FontAwesomeIcons.cartPlus),
                  ),
                ),
              ],
            )
          ],
        )
      ]),
    );
  }
}
