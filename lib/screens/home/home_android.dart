import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeAndroid extends StatefulWidget {
  @override
  _HomeAndroidState createState() => _HomeAndroidState();
}

class _HomeAndroidState extends State<HomeAndroid> {
  double waterPercentage = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Water'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.cyan,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              _buildTextField('Nome'),
              SizedBox(height: 8),
              _buildTextField('Altura'),
              SizedBox(height: 8),
              _buildTextField('Peso'),
              SizedBox(height: 32),
              _buildPercentageIndicator(),
              SizedBox(height: 32),
              _buildBarChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.cyan, width: 2),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildPercentageIndicator() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: waterPercentage / 100,
                strokeWidth: 10,
                backgroundColor: Colors.cyan.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan),
              ),
            ),
            Text(
              '$waterPercentage%',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Porcentagem de água para meta',
          style: TextStyle(fontSize: 16, color: Colors.cyan),
        ),
      ],
    );
  }

  Widget _buildBarChart() {
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
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.center,
          maxY: 10,
          barGroups: [
            for (int i = 0; i < 7; i++)
              BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(
                    toY: (i + 1).toDouble(),
                    color: Colors.cyan,
                    width: 15,
                  ),
                ],
              ),
          ],
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, getTitlesWidget: (value, meta) {
                return Text(
                  (value + 1).toInt().toString(),
                  style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 14),
                );
              }),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 14),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
        ),
      ),
    );
  }
}

