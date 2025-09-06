import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/product_detail.dart';

class ProductChart extends StatelessWidget {
  final ProductDetail productDetail;

  const ProductChart({super.key, required this.productDetail});

  @override
  Widget build(BuildContext context) {
    if (productDetail.historicalScrapeData.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(child: Text('Nessun dato storico disponibile')),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Andamento Prezzi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(height: 300, child: LineChart(_createLineChartData())),
          ],
        ),
      ),
    );
  }

  LineChartData _createLineChartData() {
    final data = productDetail.historicalScrapeData;

    // Crea i punti per il grafico
    List<FlSpot> minPriceSpots = [];
    List<FlSpot> avgPriceSpots = [];
    List<FlSpot> maxPriceSpots = [];

    for (int i = 0; i < data.length; i++) {
      minPriceSpots.add(FlSpot(i.toDouble(), data[i].minPrice));
      avgPriceSpots.add(FlSpot(i.toDouble(), data[i].avgPrice));
      maxPriceSpots.add(FlSpot(i.toDouble(), data[i].maxPrice));
    }

    // Trova il valore massimo per configurare l'asse Y
    double maxY = 0;
    for (final item in data) {
      maxY = [
        maxY,
        item.minPrice,
        item.avgPrice,
        item.maxPrice,
      ].reduce((a, b) => a > b ? a : b);
    }

    return LineChartData(
      gridData: const FlGridData(show: true),
      titlesData: FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              final index = value.toInt();
              if (index >= 0 && index < data.length) {
                final date = DateTime.parse(data[index].scrapeDate);
                return Text(
                  '${date.day}/${date.month}',
                  style: const TextStyle(fontSize: 10),
                );
              }
              return const Text('');
            },
            interval: (data.length / 5).ceil().toDouble(),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              return Text(
                '€${value.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 10),
              );
            },
            reservedSize: 40,
          ),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: (data.length - 1).toDouble(),
      minY: 0,
      maxY: maxY * 1.1,
      lineBarsData: [
        // Linea prezzo minimo
        LineChartBarData(
          spots: minPriceSpots,
          isCurved: true,
          color: Colors.green,
          barWidth: 2,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
        // Linea prezzo medio
        LineChartBarData(
          spots: avgPriceSpots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 2,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
        // Linea prezzo massimo
        LineChartBarData(
          spots: maxPriceSpots,
          isCurved: true,
          color: Colors.red,
          barWidth: 2,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}
