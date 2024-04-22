import 'package:flutter/material.dart';


class BadgeBubble extends StatelessWidget {
  final String symbol;
  final String count; 
  const BadgeBubble({
    required this.count,
    required this.symbol,
    super.key});

  @override
  Widget build(BuildContext context) {
    return 
        Container(
          height: 60,
          width: 50,
          decoration: BoxDecoration(
       // shape: BoxShape.circle,
       borderRadius: BorderRadius.circular(10),
      color: Colors.purple[100]
      //  color: Colors.purple[400]
          ),
        child: Column(children: [
          Text(symbol,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.purple,fontSize: 18),),
          Text(count,style: TextStyle(fontWeight: FontWeight.w900,color: Colors.purple,fontSize: 24))

        ],),
        // SizedBox(height: ),
        // Text(
        //   'Story',
        //   style: TextStyle(
        //     color: Colors.black,),)
      
    );
  }
}