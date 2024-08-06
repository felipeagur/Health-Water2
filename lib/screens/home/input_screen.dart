import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  @override
  _InputScreenState createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _nomeController = TextEditingController();
  final _alturaController = TextEditingController();
  final _pesoController = TextEditingController();
  String? _sexo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Water'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA), // Azul mais claro
              Color(0xFFB2EBF2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo_health.png', height: 100),
              SizedBox(height: 20),
              TextField(
                controller: _nomeController,
                decoration: InputDecoration(
                  labelText: 'Seu Nome',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Azul suave
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _alturaController,
                decoration: InputDecoration(
                  labelText: 'Altura (m)',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Azul suave
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _pesoController,
                decoration: InputDecoration(
                  labelText: 'Peso (kg)',
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Azul suave
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _sexo,
                hint: Text('Selecione o Sexo', style: TextStyle(color: Colors.black54)),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Azul suave
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Verifique se todos os campos estão preenchidos
                  if (_nomeController.text.isEmpty ||
                      _alturaController.text.isEmpty ||
                      _pesoController.text.isEmpty ||
                      _sexo == null) {
                    // Mostre uma mensagem de erro se algum campo estiver vazio
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Por favor, preencha todos os campos')),
                    );
                  } else {
                    // Realize o cálculo da quantidade de água recomendada
                    double altura = double.parse(_alturaController.text);
                    double peso = double.parse(_pesoController.text);
                    double aguaRecomendada = (_sexo == 'Masculino')
                        ? peso * 35
                        : peso * 31;

                    Navigator.pushNamed(context, '/home', arguments: {
                      'nome': _nomeController.text,
                      'altura': altura,
                      'peso': peso,
                      'sexo': _sexo,
                      'aguaRecomendada': aguaRecomendada,
                    });
                  }
                },
                child: Text('Continuar'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 116, 131), // Usar backgroundColor em vez de primary
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


