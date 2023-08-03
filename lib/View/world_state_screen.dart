import 'package:covid_tracker_app/Model/WorldStatesModel.dart';
import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose(){
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)

  ];
  @override
  Widget build(BuildContext context) {
    StatesService statesService = StatesService();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(

            children: [
              const SizedBox(height: 20),
              FutureBuilder(
                  future: statesService.fetchWorldStatesRecords(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,

                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,

                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(dataMap:  {
                            "Total": double.parse(snapshot.data!.cases.toString()),
                            "Recoverd" :double.parse(snapshot.data!.recovered.toString()),
                            "Deaths" : double.parse(snapshot.data!.deaths.toString()),

                          },
                            chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true
                            ),
                            animationDuration:const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left
                            ),
                            colorList: colorList,
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              child: Column(
                                children: [

                                  ReusableRow(tittle: 'Total', value: snapshot.data!.cases.toString()),
                                  ReusableRow(tittle: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReusableRow(tittle: 'Deaths', value: snapshot.data!.deaths.toString()),



                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),

              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CountriesList()));
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xff1aa260),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text('Track Countries'),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String tittle, value;
  ReusableRow({Key? key, required this.tittle, required this.value}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0,bottom: 5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(tittle),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}