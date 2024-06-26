import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class GraficoWidget extends StatelessWidget {
  final List<FlSpot> spots;

  const GraficoWidget({Key? key, required this.spots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 5,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: LineChart(
          LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
                isStrokeCapRound: true,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Colors.blue.withOpacity(0.3),
                ),
              ),
            ],
            minY: _calculateMinY(spots),
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              getDrawingVerticalLine: (value) {
                return FlLine(
                  color: Colors.black12,
                  strokeWidth: 1,
                );
              },
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Colors.black12,
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 22,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(0),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toStringAsFixed(2),
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateMinY(List<FlSpot> spots) {
    if (spots.isEmpty) return 0;
    double minValue = spots.first.y;
    for (var spot in spots) {
      if (spot.y < minValue) {
        minValue = spot.y;
      }
    }
    return minValue * 0.95;
  }
}