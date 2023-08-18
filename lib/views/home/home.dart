import 'package:ecommerce/views/carrinho/carrinho.dart';
import 'package:ecommerce/views/favoritos/favoritos.dart';
import 'package:ecommerce/views/shop/shop.dart';
import 'package:ecommerce/widgets/product_item/product_item_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  Home({super.key, this.user});
  UserCredential? user;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentScreen = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      Shop(
        user: widget.user!,
      ),
      Carrinho(
        cliente: widget.user!,
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Commerce"),
        actions: [
          IconButton(
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return Favoritos(
                      cliente: widget.user!,
                    );
                  });
            },
            icon: FaIcon(FontAwesomeIcons.heart),
          ),
          // IconButton(
          //     onPressed: () {
          //       showCupertinoModalPopup(
          //           context: context,
          //           builder: (context) {
          //             return Container();
          //           });
          //     },
          //     icon: Icon(Icons.wallet_travel)),
        ],
        elevation: 0,
      ),
      body: screens[currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentScreen,
        onTap: (int value) {
          setState(() {
            currentScreen = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.shop), label: ""),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.cartShopping), label: "")
        ],
      ),
    );
  }
}
