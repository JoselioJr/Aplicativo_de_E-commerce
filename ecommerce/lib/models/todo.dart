import 'dart:io';

class Produto {
  late String nome;
  late String descricao;
  File? image;

  Produto(this.nome, {this.descricao = "", this.image});
}