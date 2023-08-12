import 'package:covid19tracker/screen/word_state.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name, image;
  int totalCase, totalRecovered, active, critcal, todayRecover, test, death;
  DetailsScreen(
      {Key? key,
      required this.name,
      required this.image,
      required this.totalCase,
      required this.totalRecovered,
      required this.active,
      required this.critcal,
      required this.todayRecover,
      required this.test,
      required this.death})
      : super(key: key);

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
      body: Column(
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
                          title: 'Cases', value: widget.totalCase.toString()),
                      ReusableRow(
                          title: 'Recovered',
                          value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: 'Death', value: widget.death.toString()),
                      ReusableRow(
                          title: 'Cretical', value: widget.critcal.toString()),
                      ReusableRow(
                          title: "Active", value: widget.active.toString()),
                      ReusableRow(
                          title: 'TodayRecovred',
                          value: widget.todayRecover.toString())
                    ]),
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ]),
    );
  }
}
