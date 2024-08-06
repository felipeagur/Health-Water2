import 'package:flutter/material.dart';

class HomeAndroid extends StatefulWidget {
  @override
  _HomeAndroidState createState() => _HomeAndroidState();
}

class _HomeAndroidState extends State<HomeAndroid> {
  late String _nome;
  late double _altura;
  late double _peso;
  late String _sexo;
  late double _ingestaoAgua;
  double _ingestaoAtual = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _nome = args['nome'];
    _altura = args['altura'];
    _peso = args['peso'];
    _sexo = args['sexo'];

    _ingestaoAgua = _calcularIngestaoAgua(_peso, _sexo);
  }

  double _calcularIngestaoAgua(double peso, String sexo) {
    if (sexo == 'Masculino') {
      return peso * 35; // Exemplo: 35 ml por kg para homens
    } else {
      return peso * 31; // Exemplo: 31 ml por kg para mulheres
    }
  }

  void _adicionarAgua() {
    setState(() {
      _ingestaoAtual += 200;
      if (_ingestaoAtual > _ingestaoAgua) {
        _ingestaoAtual = _ingestaoAgua;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double porcentagem = (_ingestaoAtual / _ingestaoAgua) * 100;
    double metaTotal = _ingestaoAgua;

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
              Color(0xFFE0F7FA),
              Color(0xFFB2EBF2),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${_ingestaoAgua.toStringAsFixed(0)} ml',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Esta é a quantidade que você $_nome deve beber ao longo do dia. Por favor, não esqueça de marcar!!!',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 96, 184, 255),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 300 * ((100 - porcentagem) / 100),
                      width: MediaQuery.of(context).size.width - 32, // Ajusta a largura do contêiner
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 19, 92, 152),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 150,
                    child: Column(
                      children: [
                        Text(
                          '${_ingestaoAtual.toStringAsFixed(0)} ml',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'de ${metaTotal.toStringAsFixed(0)} ml',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _adicionarAgua,
                child: Text('+ BEBER'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 9, 226, 255),
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              Spacer(), // Adiciona espaço flexível antes do botão de edição
              ElevatedButton(
                onPressed: () async {
                  final  updatedData = await Navigator.pushNamed(context, '/edit', arguments: {
                    'nome': _nome,
                    'altura': _altura,
                    'peso': _peso,
                    'sexo': _sexo,
                  });
                },
                child: Text('Editar Informações'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 147, 167),
                  textStyle: TextStyle(fontSize: 18),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



