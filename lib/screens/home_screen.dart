import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uni_kit/components/beta_widget.dart';
import 'package:uni_kit/components/food_widget.dart';
import 'package:uni_kit/components/medico_widget.dart';
import 'package:uni_kit/components/pool_widget.dart';
import 'package:uni_kit/components/ring_widget.dart';
import 'package:uni_kit/constants/dashboard_tiles.dart';
import 'package:uni_kit/screens/medico_details_screen.dart';

class HomeScreen extends StatelessWidget {

  _contentSelection(index) {
    Widget child;
    switch (index) {
      case 0:
        child = FoodWidget();
        break;
      case 1:
        child = MedicoWidget();
        break;
      case 2:
        child = RingWidget();
        break;
      case 3:
        child = PoolWidget();
        break;
      case 4:
        child = BetaWidget();
        break;
      default:
        child = null;
    }
    
    return child;
  }

  @override
  Widget build(BuildContext context) {
    // print("Home built");
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 45.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Merhaba Hocam!",
                style: TextStyle(
                    fontFamily: "Galano",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(
                  Icons.category,
                  size: 30,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Expanded(
          child: StaggeredGridView.countBuilder(
            addAutomaticKeepAlives: true,
            crossAxisCount: 4,
            padding: EdgeInsets.all(8.0),
            itemCount: dashboardTiles.length,
            shrinkWrap: true,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: GestureDetector(
                  onTap: index == 1
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MedicoDetailsScreen()),
                          );
                        }
                      : null,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    color: dashboardTiles[index]["color"],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white24,
                          child: Icon(
                            dashboardTiles[index]["icon"],
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          dashboardTiles[index]["name"],
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        _contentSelection(index)
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
