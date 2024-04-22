import 'package:fcx_app/components/badge_bubble.dart';
import 'package:fcx_app/components/cert_item.dart';
import 'package:fcx_app/components/side_menu.dart';
import 'package:fcx_app/configurations/FutureProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
 
 
  @override
  Widget build(BuildContext context) {
    final ethBalance = context.watch<FutureCertX>();

      void _showSnackbar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('My ETH Balance ${ethBalance.balanxe}'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //   @override
  // void initState() {
  //   super.initState();
  //  //fetchJsonData();
  //   setState(() {
  //      ethBalance.init();
  //      print("estableshed");
  //     });
  // }

    return Scaffold(
      backgroundColor: Colors.purple[100],
      drawer: SideMenu(),
  
        
      
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: AssetImage("assets/web3-background.webp"),
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 110),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 196, 34, 174),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      width: double.infinity,
                      height: 180,
                      child: Center(child: Padding(
                        padding: const EdgeInsets.only(top: 75),
                        child: Column(
                          children: [
                            Text("JOHN DOE",style: TextStyle(color: Colors.white70,fontSize: 24,fontWeight: FontWeight.bold),
                            
                          ),
                          
                           Text("Software Engineer",style: TextStyle(color: Colors.white70,fontSize: 24,fontWeight: FontWeight.bold),
                            
                          ),
                          ],
                        ),
                      ),),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                          boxShadow:  [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 10,
                                
                                blurRadius: 2,
                              ),
                            ],
                             image: DecorationImage(
                            image: AssetImage("assets/john-doe.jpeg"),
                            fit: BoxFit.cover)
                          
                        ),
                        // child: Icon(
                        //   Icons.person,
                        //   color: Colors.white70,
                        //   size: 100,

                        // ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 255),
                    child: Center(
                      child: Container(
                        width: 350,
                        height: 80,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 10,
                                
                                blurRadius: 2,
                              ),
                              
                            ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [BadgeBubble(
                                  symbol: "FCX",
                                  count: "6",
                                ),BadgeBubble(
                                  symbol: "FCY",
                                  count: "3",
                                ),BadgeBubble(
                                 symbol: "FCZ",
                                 count: "0",

                                )],),
                            ),
                      ),
                    ),
                  ),
                  Container(color: Colors.transparent,height: 70,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(children: [
                      Container(
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(20)),
                      height: 40,width: 100,
                      child: Center(child:  TextButton(onPressed:(){
                        ethBalance.getEthBalance();
                        ethBalance.getMyCertsURIs();
                        _showSnackbar(context);
                      } , child:Text("Wallet",style: TextStyle(color: Colors.white,fontSize: 18),),), ),
                      )
                     
                    ],),
                  ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                             //   color:Colors.purple[100],
                //  height: 600,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (BuildContext context, int index) {
                      return CertItem();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
