import 'package:covid_tracker_app/View/world_state_screen.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases, totalDeaths,totalRecovered,active,critical,todayRecovered,test;
   DetailsScreen({required this.name,
     required this.image,
     required this.totalCases,
     required this.totalDeaths,
     required this.totalRecovered,
     required this.active,
     required this.critical,
     required this.todayRecovered,
     required this.test});

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
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: 9),
                      ReusableRow(tittle: 'Cases', value: widget.totalCases.toString()),
                      ReusableRow(tittle: 'Recovered', value:widget.totalRecovered.toString()),
                      ReusableRow(tittle: 'Death', value:widget.totalDeaths.toString()),
                      ReusableRow(tittle: 'Critical', value:widget.critical.toString()),
                      ReusableRow(tittle: 'Test', value:widget.test.toString()),
                      ReusableRow(tittle: 'Active', value:widget.active.toString()),
                      ReusableRow(tittle: 'TodayRecovered', value:widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              )
            ],
          )
        ],
      ),

    );
  }
}
