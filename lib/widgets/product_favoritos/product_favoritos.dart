import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecommerce/modals/product_details/modal_product_details.dart";
import "package:ecommerce/models/produto/produto.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:quantity_input/quantity_input.dart";

class ProductFavoritos extends StatelessWidget {
  const ProductFavoritos(
      {super.key,
      required this.cliente,
      required this.produto,
      required this.removeFavoritos});

  final VoidCallback removeFavoritos;
  final UserCredential cliente;
  final Produto produto;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
                onPressed: removeFavoritos, icon: FaIcon(FontAwesomeIcons.x))
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.photo_album,
              size: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(produto.descricao),
                Text(produto.nome),
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
                                  cliente: cliente,
                                  produto: produto,
                                );
                              });
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.upRightAndDownLeftFromCenter,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.add),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        )
      ],
    ));
  }
}
