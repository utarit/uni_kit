import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/constants/medico_departments.dart';
import 'package:uni_kit/models/medico.dart';



class MedicoWidget extends StatefulWidget  {

  @override
  _MedicoWidgetState createState() => _MedicoWidgetState();
}

class _MedicoWidgetState extends State<MedicoWidget> with AutomaticKeepAliveClientMixin {
  
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var medico = Provider.of<Medico>(context);
    // // print("Medico widget built");
    List<Doctor> data = medico?.doctors;
    if (data == null) {
      return Center(
        child: JumpingDotsProgressIndicator(fontSize: 25.0, color: Colors.white,),
      );
    } else {
      return Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              4,
              (index) {
                Doctor doctor = data[index];
                return Container(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _writeCategory(index),
                        Text(
                          "${doctor.name}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text("${doctor.status}",
                            style: TextStyle(color: Colors.white60, fontSize: 12))
                      ],
                    ));
              },
            ),
          ),
          Icon(Icons.more_horiz, color: Colors.white,)
        ],
      );
    }
  }

  _writeCategory(int index) {
    String category;
    switch (index) {
      case 0:
        category = categories[0];
        break;
      case 4:
        category = categories[1];
        break;
      case 7:
        category = categories[2];
        break;
      case 8:
        category = categories[3];
        break;
      case 9:
        category = categories[4];
        break;
      case 11:
        category = categories[5];
        break;
      case 13:
        category = categories[6];
        break;
      case 15:
        category = categories[7];
        break;
      case 16:
        category = categories[8];
        break;
      case 17:
        category = categories[9];
        break;
      case 18:
        category = categories[10];
        break;
      default:
        category = "";
        break;
    }
    if(category.isEmpty){
      return SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0,),
      child: Text(category,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 14)),
    );
  }
}

