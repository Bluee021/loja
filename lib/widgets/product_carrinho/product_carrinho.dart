import "package:ecommerce/constants/fonts.dart";
import "package:ecommerce/models/utils/convert.dart";
import "package:flutter/material.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:quantity_input/quantity_input.dart";

import "../../models/produto/produto.dart";

class ProductCarrinho extends StatelessWidget {
  const ProductCarrinho(
      {super.key,
      required this.produto,
      required this.value,
      required this.func,
      required this.onChanged});
  final Produto produto;
  final VoidCallback func;
  final Function(String) onChanged;
  final int value;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: func, icon: FaIcon(FontAwesomeIcons.x))
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.photo_album,
                  size: 80,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 0),
                      child: Text(
                        produto.nome,
                        style: stylePrecoItem,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: Text(Convert.convertReal(produto.preco)),
                        ),
                        SizedBox(
                          width: 80,
                        ),
                        QuantityInput(
                            value: value,
                            buttonColor: Color(0xff33907C),
                            onChanged: onChanged)
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
