import 'package:ecommerce/models/todo.dart';
import 'package:flutter/material.dart';

class CadastroScreen extends StatelessWidget {
  final TextEditingController _textController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produto", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 15, 15, 15),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: TextFormField(
                controller: _textController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Nome do Produto",
                  labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome do produto';
                  }
                  return null;
                },
              ),
            ),
            Row(
              children: [
                Expanded(child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        Produto novoProduto = Produto(_textController.text);
                        Navigator.pop(context, novoProduto);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 64, 187, 7),
                    ),
                    child: Text("Salvar", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
                ),
                Expanded(child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 242, 79, 4),
                    ),
                    child: Text("Cancelar", style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}