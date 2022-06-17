import 'package:covid_api/services/stats_services.dart';
import 'package:covid_api/view/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryListScreen extends StatefulWidget {
  CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
        //column lai scrollable banauna singlechildscrollview use garne
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              //for making changes in search field while typing
              onChanged: (value) {
                setState(() {});
              },
              //..
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'search countries',
                hintStyle: TextStyle(fontStyle: FontStyle.italic),
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: statsServices.fetchCountriesList(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    //adding shimmer effect
                    return ListView.builder(
                        itemCount: 9,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: ListTile(
                              title: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              subtitle: Container(
                                height: 10,
                                width: 90,
                                color: Colors.white,
                              ),
                              leading: Container(
                                height: 50,
                                width: 50,
                                color: Colors.white,
                              ),
                            ),
                          );
                        });
                  }
                  return ListView.builder(
                      // physics: AlwaysScrollableScrollPhysics()
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      //column vitra listview.builder use garesi shrinkwrap lai true garna parxa
                      itemBuilder: (context, i) {
                        String name = snapshot.data![i]['country'];

                        if (searchController.text.isEmpty) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  //constructor pass gareko..wow

                                  builder: (context) => DetailScreen(
                                    name: snapshot.data![i]['country'],
                                    image: snapshot.data![i]['countryInfo']
                                        ['flag'],
                                    totalCases: snapshot.data![i]['cases'],
                                    totalDeaths: snapshot.data![i]['deaths'],
                                    totalRecovered: snapshot.data![i]
                                        ['recovered'],
                                    active: snapshot.data![i]['active'],
                                    critical: snapshot.data![i]['critical'],
                                    test: snapshot.data![i]['tests'],
                                    todayRecovered: snapshot.data![i]
                                        ['todayRecovered'],
                                    //...
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(snapshot.data![i]['country']),
                              subtitle:
                                  Text(snapshot.data![i]['cases'].toString()),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![i]['countryInfo']['flag'],
                                ),
                              ),
                            ),
                          );
                        } else if (name
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase())) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            //constructor pass gareko ..wow

                                            name: snapshot.data![i]['country'],
                                            image: snapshot.data![i]
                                                ['countryInfo']['flag'],
                                            totalCases: snapshot.data![i]
                                                ['cases'],
                                            totalDeaths: snapshot.data![i]
                                                ['deaths'],
                                            totalRecovered: snapshot.data![i]
                                                ['recovered'],
                                            active: snapshot.data![i]['active'],
                                            critical: snapshot.data![i]
                                                ['critical'],
                                            test: snapshot.data![i]['tests'],
                                            todayRecovered: snapshot.data![i]
                                                ['todayRecovered'],

                                            //...
                                          )));
                            },
                            child: ListTile(
                              title: Text(snapshot.data![i]['country']),
                              subtitle:
                                  Text(snapshot.data![i]['cases'].toString()),
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(
                                  snapshot.data![i]['countryInfo']['flag'],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      });
                }),
          ),
        ],
      )),
    );
  }
}
