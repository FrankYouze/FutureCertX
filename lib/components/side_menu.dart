import 'dart:convert';

import 'package:fcx_app/components/pre_cert_item.dart';
import 'package:fcx_app/configurations/FutureProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  
 Map<String, dynamic>?  jsonData  = {
  "name": "Title",
  "description": "Description",
  "uri":"http://localhost"
 };

      @override
  void initState() {
    super.initState();
   //fetchJsonData();
    setState(() {
      // fetchJsonData();
      });
  }

//  Future<void> fetchJsonData() async {
//     final response = await http.get(Uri.parse('https://yellow-objective-shark-136.mypinata.cloud/ipfs/QmZmJdg27jJURy9nFDkfnehxrkzDzWqzdvMQXA5J9x1Sg2/1.json'));

    
    

// print(jsonData.toString());
 
// jsonData =  await jsonDecode(response.body);
 
      
//  }

  @override
  Widget build(BuildContext context) {

  final CertX = context.watch<FutureCertX>();


    return Drawer(
child: Column(children: [
Container(height: 200,
width: double.infinity,
color: Colors.purple,
child: Padding(
  padding: const EdgeInsets.only(top: 30),
  child: Column(
    children: [
  Text("CURRENT NETWORK",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
  SizedBox(height: 10,),
  Container(
    height: 40,
    width: 120,
   
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.black54,),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text("Sepolia",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),Icon(Icons.keyboard_arrow_down_rounded,color: Colors.white,)],),
    ),
  ),
  SizedBox(height: 10,),
 

   Container(
    height: 55,
    width: 200,
   
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black54,),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(CertX.balanxe.toStringAsFixed(4),style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
        SizedBox(width: 20,),
        Text("ETH",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)
    
        ],),
    ),
  )
    ]
  ),
),
),
Expanded(
  child: Container(
  color: Colors.purple[200],
  child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return 
                    
                     PreCert(onTap: () {
                       CertX.payToMint();
                     }, preCertTitle: 'Title: ${jsonData!['name']}',preCertDescription: 'description: ${jsonData!['description']}',preCertMetadataURL: "some uri",);
                  },
                ),
  ),
)
],),
      
    );
  }
}