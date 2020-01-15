import 'package:flutter/material.dart';

class BetaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "v.1.0.15\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
"""
    ( (            
    ) )       
  ........   
  |       |])   
  \\      /  
   `----'    

Good Luck with Finals...

(Checkout Ring Page by clicking the ring tile.)   
""",
          style: TextStyle(color: Colors.white, letterSpacing: 3),
        ),
      ],
    );
  }
}
