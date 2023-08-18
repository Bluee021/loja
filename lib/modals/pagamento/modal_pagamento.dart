import 'dart:convert';

import 'package:ecommerce/models/produto/produto.dart';
import 'package:ecommerce/models/utils/convert.dart';
import 'package:ecommerce/widgets/product_item_payment.dart/product_item_payment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';

class ModalPagamento extends StatelessWidget {
  const ModalPagamento({super.key, required this.produtos});
  final List<Produto> produtos;
  _addPagamento() async {
    Uri url = Uri.parse(
        'https://api.mercadopago.com/checkout/preferences?access_token=TEST-6103266543062774-072620-3eb6f9280359b3ceeebc5e62808484df-1433746682');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    List<Map> produdosList = [];
    for (Produto item in produtos) {
      Map map = {
        "title": item.nome,
        "description": item.descricao,
        "quantity": item.quantidade,
        "id": item.id,
        "currency_id": "BR",
        "unit_price": item.preco
      };
      produdosList.add(map);
    }

    var body = json.encode({
      "items": produdosList,
      "payer": {"email": "payer@email.com"}
    });
    var response = await http.post(url, headers: headers, body: body);
    try {
      var data = json.decode(response.body);
      String id = data["id"];

      var result = await MercadoPagoMobileCheckout.startCheckout(
          "TEST-0364bb65-ba0d-4023-a17f-ecf2bd128fb4", id);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    for (var produto in produtos) {
      total += produto.preco * produto.quantidade;
    }
    String totalFormat = Convert.convertReal(total);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento"),
      ),
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(
                height: size.height - 300,
                child: ListView(
                  children: List.generate(produtos.length, (index) {
                    Produto produto = produtos[index];
                    return ProductItemPayment(produto: produto);
                  }),
                ),
              ),
              Divider(
                height: 2,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Text(
                      "Total: $totalFormat",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                  child: Text("Pagamento"),
                  onPressed: _addPagamento,
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width - 20, 50))),
            ],
          )),
    );
  }
}
