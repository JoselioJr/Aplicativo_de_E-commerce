import 'package:flutter/material.dart';
import 'package:ecommerce/meus_produtos_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("App E-Commerce", style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 236, 232, 229),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MeusProdutosScreen()),
              );
            },
            child: Container(
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 242, 79, 4),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag, color: Colors.white, size: 24),
                  SizedBox(width: 10),
                  Text(
                    "Meus Produtos",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}