class Produto {
  String nome;
  double preco;
  String descricao;
  String categoria;
  String id;
  int quantidade;
  Produto(this.descricao, this.preco, this.categoria, this.id,
      {this.nome = '', this.quantidade = 0});
}
