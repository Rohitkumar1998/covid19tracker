import 'package:covid19tracker/Servcies/state_services.dart';
import 'package:covid19tracker/screen/details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker/Servcies/state_services.dart';
import 'package:covid19tracker/Servcies/state_services.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController serchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServies stateServies = StateServies();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: serchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with Country Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50))),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: stateServies.countriesListAPi(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (!snapshot.hasData) {
                return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        child: Column(
                          children: [
                            ListTile(
                              title: Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 80,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade100,
                      );
                    });
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (serchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                              name: snapshot.data![index]
                                                  ['country'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              totalCase: snapshot.data![index]
                                                  ['cases'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critcal: snapshot.data![index]
                                                  ['critical'],
                                              todayRecover:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              death: snapshot.data![index]
                                                  ['deaths'],
                                            )));
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(snapshot.data![index]
                                        ['countryInfo']['flag'])),
                              ),
                            )
                          ],
                        );
                      } else if (name
                          .toLowerCase()
                          .contains(serchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                              name: snapshot.data![index]
                                                  ['country'],
                                              image: snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                              totalCase: snapshot.data![index]
                                                  ['cases'],
                                              totalRecovered: snapshot
                                                  .data![index]['recovered'],
                                              active: snapshot.data![index]
                                                  ['active'],
                                              critcal: snapshot.data![index]
                                                  ['critical'],
                                              todayRecover:
                                                  snapshot.data![index]
                                                      ['todayRecovered'],
                                              test: snapshot.data![index]
                                                  ['tests'],
                                              death: snapshot.data![index]
                                                  ['deaths'],
                                            )));
                              },
                            ),
                            ListTile(
                              title: Text(snapshot.data![index]['country']),
                              subtitle: Text(
                                  snapshot.data![index]['cases'].toString()),
                              leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag'])),
                            )
                          ],
                        );
                      } else {
                        Container();
                      }
                    });
              }
            },
          ))
        ],
      )),
    );
  }
}