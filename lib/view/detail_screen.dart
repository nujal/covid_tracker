import 'package:covid_api/view/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases,
      totalDeaths,
      totalRecovered,
      active,
      critical,
      todayRecovered,
      test;
  DetailScreen(
      {required this.name,
      required this.image,
      required this.totalCases,
      required this.totalDeaths,
      required this.todayRecovered,
      required this.active,
      required this.critical,
      required this.test,
      required this.totalRecovered});

  //constructor pass garna ko lagi sab define garna paryo

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
            alignment: AlignmentDirectional.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .08,
                      ),
                      ReusableRow(
                          title: 'total cases',
                          value: widget.totalCases.toString()),
                      ReusableRow(
                          title: 'deaths',
                          value: widget.totalDeaths.toString()),
                      ReusableRow(
                          title: 'recovered',
                          value: widget.totalRecovered.toString()),
                      ReusableRow(
                          title: 'active', value: widget.active.toString()),
                      ReusableRow(
                          title: 'critical', value: widget.critical.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(widget.image),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
