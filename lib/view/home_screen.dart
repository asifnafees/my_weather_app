import 'package:flutter/material.dart';
import 'package:my_weather_app/models/weather_data.dart';
import 'package:my_weather_app/services/api_service.dart';
import 'package:my_weather_app/view/constant.dart';
import 'package:my_weather_app/view/reusable_button.dart';
import 'package:my_weather_app/view/reusable_container.dart';
import 'package:my_weather_app/view/search_city.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<WeatherDataModel> futureWeatherData= ApiService().fetchWeatherData();
  Color getBackgroundColor(String description) {
    switch (description.toLowerCase()) {
      case 'clear sky':
        return Colors.blue;
      case 'few clouds':
      case 'scattered clouds':
      case 'broken clouds':
        return Colors.grey;
      case 'shower rain':
      case 'rain':
        return Colors.blueGrey;
      case 'thunderstorm':
        return Colors.deepPurple;
      case 'snow':
        return Colors.lightBlueAccent;
      case 'mist':
        return Colors.teal;
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade700,

      body: SingleChildScrollView(child:
      Padding(
        padding: const EdgeInsets.only(top: 100 ),
        child: FutureBuilder<WeatherDataModel>(
          future: futureWeatherData,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }else{
              WeatherDataModel data = snapshot.data!;
              return Center(
                child: Column( mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Container(
                        height: MediaQuery.of(context).size.height*.6,
                        width: MediaQuery.of(context).size.width*.8,
                        decoration: BoxDecoration(color: getBackgroundColor(data.description),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,spreadRadius: 10,
                                  color: getBackgroundColor(data.description),
                                  blurStyle: BlurStyle.outer
                              )
                            ]),

                        child: SafeArea(
                          child: Center(
                            child: Column( mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('Firozabad',style: TextStyle(
                                  color: Colors.blueAccent,fontSize: 25,
                                  fontWeight: FontWeight.w700
                              ),),
                                Image.network(
                                  'http://openweathermap.org/img/wn/${data.icon}@2x.png',
                                  scale: 1.0,
                                ),

                                Text('${data.temperature}°C',
                                    style: tempTempratureStyle),
                                Text(data.description,style: tempDescriptionStyle,),
                                SizedBox(height: MediaQuery.of(context).size.height*.1,),
                                Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ReusableContainer(title: "Feel Like", value: data.feelsLike),
                                    ReusableContainer(title: "Humidity", value: data.humidity.toDouble()),
                                    ReusableContainer(title: "Wind Speed", value: data.windSpeed),
                                  ],)

                              ],
                            ),
                          ),
                        ),

                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.1,),
                      ReusableButton(title: "Search your city",
                        voidCallback: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchCity(),));
                        },)
                    ]),
              );
            }

          },
        ),
      ),)
    );
  }
}
