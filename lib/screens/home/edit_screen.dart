import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nomeController;
  late TextEditingController _alturaController;
  late TextEditingController _pesoController;
  String _sexo = 'Masculino';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _nomeController = TextEditingController(text: args['nome']);
    _alturaController = TextEditingController(text: args['altura'].toString());
    _pesoController = TextEditingController(text: args['peso'].toString());
    _sexo = args['sexo'];
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA),
              Color(0xFFB2EBF2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              DropdownButton<String>(
                value: _sexo,
                onChanged: (String? newValue) {
                  setState(() {
                    _sexo = newValue!;
                  });
                },
                items: <String>['Masculino', 'Feminino']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'nome': _nomeController.text,
                    'altura': double.parse(_alturaController.text),
                    'peso': double.parse(_pesoController.text),
                    'sexo': _sexo,
                  });
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





