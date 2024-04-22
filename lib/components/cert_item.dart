import 'package:flutter/material.dart';

class CertItem extends StatelessWidget {
  const CertItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Container(
          height: 300,
          child: Image(image: AssetImage("assets/1.jpg"),),),
          Text("SAMPLE CERTIFICATE")
          ],
      ),
    );
  }
}
