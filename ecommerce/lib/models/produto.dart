import 'dart:io';
import 'package:hive/hive.dart';

part 'produto.g.dart';

@HiveType(typeId: 0)
class Produto {
  @HiveField(0)
  late String nome;
  
  @HiveField(1)
  late String descricao;
  
  @HiveField(2)
  late double valor;
  
  @HiveField(3)
  String? imagePath;

  File? get image => imagePath != null ? File(imagePath!) : null;
  set image(File? file) => imagePath = file?.path;

  Produto(this.nome, {this.descricao = "", this.valor = 0.0, File? image}) {
    this.image = image;
  }
}