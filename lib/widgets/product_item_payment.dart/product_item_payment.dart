import "package:ecommerce/constants/fonts.dart";
import "package:ecommerce/models/utils/convert.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:quantity_input/quantity_input.dart";

import "../../models/produto/produto.dart";

class ProductItemPayment extends StatelessWidget {
  const ProductItemPayment({
    super.key,
    required this.produto,
  });
  final Produto produto;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Row(
          children: [
            Icon(
              Icons.photo_album,
              size: 70,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(produto.nome, style: styleTiltleItem),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Text(produto.descricao, style: styleDescricaoItem),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        Convert.convertReal(produto.preco) +
                            "   X   " +
                            produto.quantidade.toString() +
                            " und",
                        style: stylePrecoItem,
                      ),
                    ),
                    SizedBox(
                      width: 80,
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
