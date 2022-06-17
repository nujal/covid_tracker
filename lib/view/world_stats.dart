import 'package:covid_api/models/world_stats_model.dart';
import 'package:covid_api/services/stats_services.dart';
import 'package:covid_api/view/countrylist_screen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStats extends StatefulWidget {
  WorldStats({Key? key}) : super(key: key);

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final ColorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];
  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .06,
              ),
              FutureBuilder<WorldStatsModel?>(
                future: statsServices.fetchWorldStatsRecords(),
                builder: (context, AsyncSnapshot<WorldStatsModel?> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total':
                                double.parse(snapshot.data!.cases.toString()),
                            'Recovered': double.parse(
                                snapshot.data!.recovered.toString()),
                            'Deaths':
                                double.parse(snapshot.data!.deaths.toString()),
                          },
                          colorList: ColorList,
                          chartType: ChartType.ring,
                          chartRadius: MediaQuery.of(context).size.width / 2.7,
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(
                                    title: 'total cases',
                                    value: snapshot.data!.cases.toString()),
                                ReusableRow(
                                    title: 'deaths',
                                    value: snapshot.data!.deaths.toString()),
                                ReusableRow(
                                    title: 'recovered',
                                    value: snapshot.data!.recovered.toString()),
                                ReusableRow(
                                    title: 'active',
                                    value: snapshot.data!.active.toString()),
                                ReusableRow(
                                    title: 'critical',
                                    value: snapshot.data!.critical.toString()),
                              ],
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 60,
                        //   width: 250,
                        //   decoration: BoxDecoration(
                        //     color: Colors.purple[700],
                        //     borderRadius: BorderRadius.circular(15),
                        //   ),
                        //   child: const Center(
                        //     child: Text('Track Countries'),
                        //   ),
                        // ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 7.0,
                            fixedSize: Size(150, 47),
                            primary: Colors.purple,
                            padding: EdgeInsets.all(10.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryListScreen()));
                          },
                          child: Text('Track Countries'),
                        ),
                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 2,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
