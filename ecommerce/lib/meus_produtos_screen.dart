import 'package:ecommerce/cadastro_screen.dart';
import 'package:ecommerce/models/produto.dart';
import 'package:ecommerce/produto_detalhes_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MeusProdutosScreen extends StatefulWidget {
  const MeusProdutosScreen({Key? key}) : super(key: key);

  @override
  _MeusProdutosScreenState createState() => _MeusProdutosScreenState();
}
class _MeusProdutosScreenState extends State<MeusProdutosScreen> {
  List<Produto> _produtos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produtos", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 236, 232, 229),
          leading: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Menu pricipal",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "Meus produtos",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  final produto = _produtos[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: produto.image != null 
                            ? (kIsWeb 
                                ? Image.network(produto.image!.path, width: 150, height: 150, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported))
                                : Image.file(produto.image!, width: 150, height: 150, fit: BoxFit.cover)) 
                            : null,
                        title: Text(produto.nome, style: TextStyle(fontSize: 18, color: Colors.black)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(produto.descricao, style: TextStyle(fontSize: 14, color: Colors.grey, fontStyle: FontStyle.italic)),
                            SizedBox(height: 4),
                            Text("R\$ ${produto.valor.toStringAsFixed(2)}", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 64, 187, 7), fontWeight: FontWeight.bold)),
                          ],
                        ),
                        onTap: () async {
                          dynamic resultado = await Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProdutoDetalhesScreen(produto: produto)),
                          );
                          if (resultado == 'delete') {
                            setState(() {
                              _produtos.removeAt(index);
                            });
                          } else if (resultado is Produto) {
                            setState(() {
                              _produtos[index] = resultado;
                            });
                          }
                        },
                        onLongPress: () async {
                          showBottomSheet(context: context, builder: (context) {
                            return Container(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.email, color: Colors.black),
                                    title: Text("Envir por E-mail", style: TextStyle(color: Colors.black)),
                                    onTap: () async {
                                      Navigator.pop(context);
                                      
                                      final uri = Uri(
                                        scheme: 'mailto',
                                        path: 'joselio.junior@estudante.ifgoiano.edu.br',
                                        queryParameters: {
                                          "subject": "Produto ${produto.nome}",
                                          "body": "Olá, gostaria de comprar o produto ${produto.nome} anunciado no seu app."
                                        },
                                      );

                                      final url = uri.toString();
                                      if (await canLaunchUrl(url as Uri)) {
                                        await launch(url);
                                      } else {
                                        print("Erro ao enviar o E-mail");
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.messenger, color: Colors.black),
                                    title: Text("Envir por SMS", style: TextStyle(color: Colors.black)),
                                    onTap: () async {
                                      Navigator.pop(context);

                                      final uri = Uri(
                                        scheme: 'sms',
                                        path: '(64) 99999-9999',
                                        queryParameters: {
                                          "body": "Olá, gostaria de comprar o produto ${produto.nome} anunciado no seu app."
                                        },
                                      );

                                      final url = uri.toString();
                                      if (await canLaunchUrl(url as Uri)) {
                                        await launch(url);
                                      } else {
                                        print("Erro ao enviar o SMS");
                                      }
                                    },
                                  )
                                ],
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ),
            ),
          ],
        ),    
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              Produto? produto = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroScreen()),
              );
              if (produto != null) {
                setState(() {
                  _produtos.add(produto);
                });
              }
            } catch (e) {
              print("Error: ${e.toString()}");
            }
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 242, 79, 4),
          foregroundColor: Colors.white,
        ),
        
    );
  }
}