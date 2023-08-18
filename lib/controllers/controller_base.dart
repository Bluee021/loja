import 'package:mobx/mobx.dart';

import '../models/produto/produto.dart';
part 'controller_base.g.dart';

class Controller = ControllerBase with _$Controller;

abstract class ControllerBase with Store {
  @observable
  List<Produto> carrinho = [];

  @action
  setCarrinho(List<Produto> produtos) {
    carrinho = produtos;
  }

  @action
  addCarrinho(Produto produto) {
    carrinho.add(produto);
  }
}
