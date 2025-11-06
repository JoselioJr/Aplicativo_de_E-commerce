import 'dart:io';

class Produto {
  late String nome;
  late String descricao;
  late double valor;
  File? image;

  Produto(this.nome, {this.descricao = "", this.valor = 0.0, this.image});
}