import 'package:covid19tracker/screen/word_state.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalRecovered,
      active,
      critcal,
      todayRecover,
      test,
      totalDeaths;
  DetailsScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalRecovered,
      required this.active,
      required this.critcal,
      required this.todayRecover,
      required this.test,
      required this.totalDeaths});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      child: Column(children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        ReusableRow(
                            title: 'Cases',
                            value: widget.totalCases.toString()),
                        ReusableRow(
                            title: 'Recovered',
                            value: widget.totalRecovered.toString()),
                        ReusableRow(
                            title: 'totalDeath',
                            value: widget.totalDeaths.toString()),
                        ReusableRow(
                            title: 'Cretical',
                            value: widget.critcal.toString()),
                        ReusableRow(
                            title: "Active", value: widget.active.toString()),
                        ReusableRow(
                            title: 'TodayRecovred',
                            value: widget.todayRecover.toString())
                      ]),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
