import 'package:covid_tracker_app/Services/states_services.dart';
import 'package:covid_tracker_app/View/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StatesService statesService  = StatesService();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              TextFormField(
                controller: searchController,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search country name',
                  contentPadding: EdgeInsets.all(9.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)
                  )
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future: statesService.countriesListApi(),
                    builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
                      if(!snapshot.hasData){
                        return ListView.builder(
                          itemCount: 4,
                            //itemCount:snapshot.data!.length,
                            itemBuilder: (context, index){
                              return Shimmer.fromColors(
                                  baseColor: Colors.grey.shade700,
                                  highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                  ListTile(
                                  title :Container(height: 9, width: 9, color: Colors.white,),
                              subtitle : Container(height: 9, width: 9, color: Colors.white,),
                              leading: Container(height: 50, width: 50, color: Colors.white,),
                              )
                              ],
                              )

                              );
                            }
                            );

                      }else{

                      }
                      return ListView.builder(

                        itemCount:snapshot.data!.length ,
                          itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalRecovered:snapshot.data![index]['recovered'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                    )));
                                  },
                                  child: ListTile(
                                    title :Text(snapshot.data![index]['country']),
                                    subtitle : Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width:50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  ),
                                )
                              ],
                            );

                          }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalRecovered:snapshot.data![index]['recovered'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                    )));

                            },
                                  child: ListTile(
                                    title :Text(snapshot.data![index]['country']),
                                    subtitle : Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height: 50,
                                      width:50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),),
                                  ),
                                )
                              ],
                            );

                          }else{
                            return Container();
                          }

                      });
                    })
              )],
          ),
        ),
      ),

    );
  }
}
