import 'package:ecommerce/cadastro_screen.dart';
import 'package:ecommerce/models/todo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
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
              child: Text(
                "Menu dos Produtos",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: _produtos.length,
                itemBuilder: (context, index) {
                  final produto = _produtos[index];
                  return ListTile(
                    title: Text(produto.nome, style: TextStyle(fontSize: 18, color: Colors.black)),
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
