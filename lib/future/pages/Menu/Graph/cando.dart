import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';
import 'package:smaill_project/future/component/List_Local.dart';

class CandoCase extends StatefulWidget {
  final List none;
  final List hight;
  final List midle;
  final List low;

  const CandoCase({
    super.key,
    required this.none,
    required this.hight,
    required this.midle,
    required this.low,
  });
  @override
  State<CandoCase> createState() => _CandoCaseState();
}

class _CandoCaseState extends State<CandoCase> {
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(
              border: Border.all(width: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            height: 300,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: chartToRun(),
            )),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              border: TableBorder.all(width: 0.3),
              columns: <DataColumn>[
                const DataColumn(
                  label: Text('Totle',
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ),
                for (int i = 0; i < listPro.length; i++)
                  DataColumn(
                    label: Text(
                      listPro[i]['title'].toString(),
                      style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text(
                        '${widget.none.length + widget.hight.length + widget.midle.length + widget.low.length}')),
                    DataCell(Text(widget.none.length.toString())),
                    DataCell(Text(widget.hight.length.toString())),
                    DataCell(Text(widget.midle.length.toString())),
                    DataCell(Text(widget.low.length.toString())),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget chartToRun() {
    LabelLayoutStrategy? xContainerLabelLayoutStrategy;
    ChartData chartData;
    ChartOptions chartOptions = const ChartOptions();

    chartData = ChartData(
      dataRows: [
        [
          double.parse(widget.none.length.toString()),
          double.parse(widget.hight.length.toString()),
          double.parse(widget.midle.length.toString()),
          double.parse(widget.low.length.toString()),
        ],
      ],
      xUserLabels: [
        'None (${widget.none.length})',
        'Hight (${widget.hight.length})',
        'Midle (${widget.midle.length})',
        'Low (${widget.low.length})',
      ],
      dataRowsLegends: [
        'Case All ${widget.none.length + widget.hight.length + widget.midle.length + widget.low.length}',
      ],
      dataRowsColors: const [
        Color.fromARGB(255, 233, 11, 11),
      ],
      chartOptions: chartOptions,
    );
    var lineChartContainer = LineChartTopContainer(
      chartData: chartData,
      xContainerLabelLayoutStrategy: xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(
        lineChartContainer: lineChartContainer,
      ),
    );
    return lineChart;
  }
}
