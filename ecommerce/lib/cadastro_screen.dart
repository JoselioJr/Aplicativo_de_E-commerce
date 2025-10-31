import 'dart:io';

import 'package:ecommerce/models/todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class CadastroScreen extends StatefulWidget {
  @override
  _CadastroScreenState createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _image;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Produto", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 15, 15, 15),
      ),
      body: Column(
        children: [
          GestureDetector(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.grey,
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: _image == null
                  ? Icon(Icons.add_a_photo, size: 30)
                  : (kIsWeb 
                      ? Image.network(_image!.path, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.image_not_supported))
                      : Image.file(_image!, fit: BoxFit.cover)),
            ),
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              final XFile? image = await _picker.pickImage(source: ImageSource.camera);
              if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
              }
            },
          ),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: TextFormField(
                    controller: _textController,
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    controller: _descriptionController,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "Descrição do Produto",
                      labelStyle: TextStyle(fontSize: 18, color: Colors.grey),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a descrição do produto';
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
                            Produto novoProduto = Produto(_textController.text, descricao: _descriptionController.text, image: _image);
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
        ],
      ),
    );
  }
}