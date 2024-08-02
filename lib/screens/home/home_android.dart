import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeAndroid extends StatefulWidget {
  @override
  _HomeAndroidState createState() => _HomeAndroidState();
}

class _HomeAndroidState extends State<HomeAndroid> {
  late String _nome;
  late double _altura;
  late double _peso;
  late String _sexo;
  late double _waterIntake;
  double _currentWaterIntake = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _nome = args['nome'];
    _altura = args['altura'];
    _peso = args['peso'];
    _sexo = args['sexo'];

    _waterIntake = _calculateWaterIntake(_peso, _sexo);
  }

  double _calculateWaterIntake(double peso, String sexo) {
    if (sexo == 'Masculino') {
      return peso * 35; // Exemplo: 35 ml por kg para homens
    } else {
      return peso * 31; // Exemplo: 31 ml por kg para mulheres
    }
  }

  void _addWater() {
    setState(() {
      _currentWaterIntake += 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (_currentWaterIntake / _waterIntake) * 100;
    double totalGoal = _waterIntake;

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
              _buildLineChart(),
              SizedBox(height: 32),
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: percentage / 100,
                      strokeWidth: 10,
                      backgroundColor: Colors.cyan.shade100,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_currentWaterIntake.toStringAsFixed(0)} ml',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'de ${totalGoal.toStringAsFixed(0)} ml',
                        style: TextStyle(fontSize: 16, color: Colors.cyan),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 32),
              FloatingActionButton(
                onPressed: _addWater,
                child: Icon(Icons.local_drink),
              ),
              Spacer(), // Adiciona espaço flexível antes do botão de edição
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/edit', arguments: {
                    'nome': _nome,
                    'altura': _altura,
                    'peso': _peso,
                    'sexo': _sexo,
                  });
                },
                child: Text('Editar Informações'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    final spots = [
      FlSpot(0, 500),
      FlSpot(1, 700),
      FlSpot(2, 600),
      FlSpot(3, 800),
      FlSpot(4, 750),
      FlSpot(5, 900),
      FlSpot(6, 1000),
    ];

    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.cyan,
              dotData: FlDotData(show: false),
              belowBarData: BarAreaData(show: false),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      '${value.toInt()}d', // Exemplo: dia 1, dia 2, etc.
                      style: TextStyle(color: Colors.cyan, fontSize: 14),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 200,
                getTitlesWidget: (value, meta) {
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(
                      '${value.toInt()} ml',
                      style: TextStyle(color: Colors.cyan, fontSize: 14),
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.cyan, width: 1),
          ),
          gridData: FlGridData(show: true),
        ),
      ),
    );
  }
}







