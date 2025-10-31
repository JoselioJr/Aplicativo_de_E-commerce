import 'package:ecommerce/cadastro_screen.dart';
import 'package:ecommerce/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(255, 15, 15, 15),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Produto> _produtos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Produtos", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 15, 15, 15),
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
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    "Meus produtos",
                    style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 170, 170, 170)),
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
                        color: Color.fromARGB(255, 33, 33, 33),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        leading: produto.image != null 
                            ? (kIsWeb 
                                ? Image.network(produto.image!.path, width: 150, height: 150, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported))
                                : Image.file(produto.image!, width: 150, height: 150, fit: BoxFit.cover)) 
                            : null,
                        title: Text(produto.nome, style: TextStyle(fontSize: 18, color: Colors.white)),
                        subtitle: Text(produto.descricao, style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 170, 170, 170), fontStyle: FontStyle.italic)),
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
