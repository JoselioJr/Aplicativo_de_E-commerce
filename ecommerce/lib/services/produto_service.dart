import 'package:hive/hive.dart';
import '../models/produto.dart';

class ProdutoService {
  static const String _boxName = 'produtos';
  
  static Future<Box<Produto>> _getBox() async {
    return await Hive.openBox<Produto>(_boxName);
  }
  
  static Future<List<Produto>> getProdutos() async {
    final box = await _getBox();
    return box.values.toList();
  }
  
  static Future<void> addProduto(Produto produto) async {
    final box = await _getBox();
    await box.add(produto);
  }
  
  static Future<void> updateProduto(int index, Produto produto) async {
    final box = await _getBox();
    await box.putAt(index, produto);
  }
  
  static Future<void> deleteProduto(int index) async {
    final box = await _getBox();
    await box.deleteAt(index);
  }
}