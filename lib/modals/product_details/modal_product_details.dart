import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/constants/fonts.dart';
import 'package:ecommerce/models/produto/produto.dart';
import 'package:ecommerce/models/utils/convert.dart';
import 'package:ecommerce/views/carrinho/carrinho.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    super.key,
    required this.cliente,
    required this.produto,
  });
  final UserCredential cliente;
  final Produto produto;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  _addFavoritos() async {
    Produto produto = widget.produto;
    DocumentReference cliente = FirebaseFirestore.instance
        .collection("cliente")
        .doc(widget.cliente.user!.uid)
        .collection("favoritos")
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

  _addCarrinho() async {
    Produto produto = widget.produto;

    CollectionReference cliente = FirebaseFirestore.instance
        .collection("cliente")
        .doc(widget.cliente.user!.uid)
        .collection("carrinho");
    await cliente.add({
      "nome": produto.nome,
      "preco": produto.preco,
      "descricao": produto.descricao,
      "categoria": produto.categoria
    }).then((value) {
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Carrinho(
      //               cliente: widget.cliente,
      //             )));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Produto produto = widget.produto;
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(200),
          child: AppBar(
              elevation: 0,
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                IconButton(
                    onPressed: _addFavoritos,
                    icon: const FaIcon(FontAwesomeIcons.heartCirclePlus)),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.three_p_sharp))
              ],
              flexibleSpace: const SizedBox(
                height: 200,
                child: Image(
                  image: NetworkImage(
                      'https://th.bing.com/th/id/OIP.AjOYK61Fo6R4XdkOHnh_UQHaBr?pid=ImgDet&rs=1'),
                  fit: BoxFit.fill,
                ),
              )),
        ),
        body: Container(
            margin: const EdgeInsets.only(top: 200),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.grey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            produto.nome,
                            style: styleTiltleItem,
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 0, left: 10, bottom: 20),
                          child: Text(
                            Convert.convertReal(produto.preco),
                            style: stylePrecoItem,
                          ),
                        )
                      ]),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 3))
                      ],
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 40,
                        child: const Text("C"),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            border: Border.all(width: 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                      title: Text(
                        produto.categoria,
                        style: styleTiltleItem,
                      ),
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3))
                    ],
                  ),
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  child: Text(
                    widget.produto.descricao,
                    style: styleDescricaoItem,
                  ),
                ),
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                fixedSize: Size(MediaQuery.of(context).size.width, 50)),
            onPressed: _addCarrinho,
            child: const Text("Add to Cart"),
          ),
        ),
      ),
    );
  }
}
