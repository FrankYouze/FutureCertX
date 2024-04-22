import 'dart:ffi';

import 'package:flutter/material.dart';

class PreCert extends StatelessWidget {
final String preCertTitle;
final String preCertDescription;
final String preCertMetadataURL;
final Function()? onTap;

    PreCert({
    Key? key,
    required this.preCertTitle,
    required this.preCertDescription,
    required this.preCertMetadataURL,
    required this.onTap
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text(preCertTitle),
        Text(preCertDescription),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,),
          onPressed: onTap, child: Text("REDEEM FCX",style: TextStyle(color: Colors.white),)),
          Divider()
        ],),
      ),

    );
  }
}