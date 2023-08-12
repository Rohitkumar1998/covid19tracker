import 'package:covid19tracker/Model/world_states_model.dart';
import 'package:covid19tracker/Servcies/state_services.dart';
import 'package:covid19tracker/screen/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WordStateData extends StatefulWidget {
  const WordStateData({Key? key}) : super(key: key);

  @override
  State<WordStateData> createState() => _WordStateDataState();
}

class _WordStateDataState extends State<WordStateData>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 3))
        ..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StateServies stateServies = StateServies();
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .01,
          ),
          FutureBuilder(
              future: stateServies.fetchWordStatesRecord(),
              builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50,
                        controller: _controller,
                      ));
                } else {
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          'Total':
                              double.parse(snapshot.data!.cases!.toString()),
                          'Recovered':
                              double.parse(snapshot.data!.recovered.toString()),
                          'Death':
                              double.parse(snapshot.data!.deaths.toString())
                        },
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                        chartRadius: MediaQuery.of(context).size.height / 3.2,
                        legendOptions:
                            LegendOptions(legendPosition: LegendPosition.left),
                        animationDuration: const Duration(milliseconds: 1200),
                        chartType: ChartType.ring,
                        colorList: colorList,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .06),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(
                                  title: 'Total',
                                  value: snapshot.data!.cases.toString()),
                              ReusableRow(
                                  title: 'Deaths',
                                  value: snapshot.data!.deaths.toString()),
                              ReusableRow(
                                  title: 'Recovere',
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: 'Active',
                                  value: snapshot.data!.recovered.toString()),
                              ReusableRow(
                                  title: 'Critical',
                                  value: snapshot.data!.casesPerOneMillion
                                      .toString()),
                              ReusableRow(
                                  title: 'Today Deaths',
                                  value: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(
                                  title: 'Today Recovered',
                                  value:
                                      snapshot.data!.todayRecovered.toString())
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (conatext) =>
                                      CountriesListScreen()));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(child: Text('Treack Countries')),
                        ),
                      )
                    ],
                  );
                }
              }),
        ]),
      ),
    ));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(title), Text(value)]),
          SizedBox(
            height: 5,
          ),
          Divider()
        ],
      ),
    );
  }
}
