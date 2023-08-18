// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_base.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on ControllerBase, Store {
  late final _$carrinhoAtom =
      Atom(name: 'ControllerBase.carrinho', context: context);

  @override
  List<Produto> get carrinho {
    _$carrinhoAtom.reportRead();
    return super.carrinho;
  }

  @override
  set carrinho(List<Produto> value) {
    _$carrinhoAtom.reportWrite(value, super.carrinho, () {
      super.carrinho = value;
    });
  }

  late final _$ControllerBaseActionController =
      ActionController(name: 'ControllerBase', context: context);

  @override
  dynamic setCarrinho(List<Produto> produtos) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.setCarrinho');
    try {
      return super.setCarrinho(produtos);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addCarrinho(Produto produto) {
    final _$actionInfo = _$ControllerBaseActionController.startAction(
        name: 'ControllerBase.addCarrinho');
    try {
      return super.addCarrinho(produto);
    } finally {
      _$ControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
carrinho: ${carrinho}
    ''';
  }
}
