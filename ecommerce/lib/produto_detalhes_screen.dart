import 'dart:io';
import 'package:ecommerce/models/produto.dart';
import 'package:ecommerce/cadastro_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ProdutoDetalhesScreen extends StatelessWidget {
  final Produto produto;
  
  const ProdutoDetalhesScreen({Key? key, required this.produto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhes do Produto", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 236, 232, 229),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey),
                ),
                child: produto.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: kIsWeb 
                            ? Image.network(
                                produto.image!.path, 
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => 
                                    Icon(Icons.image_not_supported, size: 50, color: Colors.grey)
                              )
                            : Image.file(produto.image!, fit: BoxFit.cover),
                      )
                    : Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Nome:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              produto.nome,
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
            SizedBox(height: 24),
            
            Text(
              "Descrição:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              produto.descricao.isNotEmpty ? produto.descricao : "Sem descrição",
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 24),
            
            Text(
              "Valor:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              "R\$ ${produto.valor.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 64, 187, 7)),
            ),
            
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      dynamic resultado = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CadastroScreen(produto: produto)),
                      );
                      if (resultado != null) {
                        Navigator.pop(context, resultado);
                      }
                    },
                    icon: Icon(Icons.edit, color: Colors.white),
                    label: Text("Editar", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 64, 187, 7),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Confirmar exclusão"),
                          content: Text("Tem certeza que deseja excluir o produto '${produto.nome}'?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Cancelar"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context, 'delete');
                              },
                              child: Text("Excluir", style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text("Excluir", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}