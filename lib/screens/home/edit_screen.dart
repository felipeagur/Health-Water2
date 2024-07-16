import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _alturaController;
  late TextEditingController _pesoController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _nomeController = TextEditingController(text: args['nome']);
    _alturaController = TextEditingController(text: args['altura'].toString());
    _pesoController = TextEditingController(text: args['peso'].toString());
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Informações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _alturaController,
              decoration: InputDecoration(labelText: 'Altura'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(labelText: 'Peso'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'nome': _nomeController.text,
                  'altura': double.parse(_alturaController.text),
                  'peso': double.parse(_pesoController.text),
                });
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
