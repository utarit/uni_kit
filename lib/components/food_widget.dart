import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/models/food.dart';

class FoodWidget extends StatefulWidget {
  @override
  _FoodWidgetState createState() => _FoodWidgetState();
}

class _FoodWidgetState extends State<FoodWidget>
    with AutomaticKeepAliveClientMixin {


  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    // // print("Food Widget built");
    Food food = Provider.of<Food>(context);

    if (food != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.wb_sunny, color: Colors.white),
                SizedBox(
                  width: 4,
                ),
                Text("Lunch",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16))
              ],
            ),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(food.lunch.length, (index) {
                  return Text(food.lunch[index],
                      style: TextStyle(color: Colors.white));
                })),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.brightness_3, color: Colors.white),
                SizedBox(
                  width: 4,
                ),
                Text("Dinner",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16))
              ],
            ),
          ),
          Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(food.dinner.length, (index) {
                  return Text(food.dinner[index],
                      style: TextStyle(color: Colors.white));
                })),
          ),
        ],
      );
    } else if (DateTime.now().weekday > DateTime.friday) {
      return Center(
          child: Text("Haftasonu Yemekhane Kapalı :(",
              style: TextStyle(color: Colors.white)));
    }
    return Center(
        child: JumpingDotsProgressIndicator(fontSize: 25.0, color: Colors.white,),);
  }
}
