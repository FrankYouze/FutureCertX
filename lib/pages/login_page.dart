
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fcx_app/components/my_button.dart';
import 'package:fcx_app/components/my_textfield.dart';
import 'package:fcx_app/configurations/FutureProvider.dart';
import 'package:fcx_app/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final userEmailcon = TextEditingController();
  final passcon = TextEditingController();

// void signInUser()async{

// await FirebaseAuth.instance.signInWithEmailAndPassword(
//   email: userEmailcon.text,
//    password: passcon.text);

// }
  @override
  Widget build(BuildContext context) {
 final Certs = context.watch<FutureCertX>();


    return Scaffold(
     backgroundColor: Colors.purple[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                const Text(
                  "Sign In",
                  style: TextStyle(
                      color: Color.fromARGB(255, 44, 43, 43),
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  myText: "enter user name",
                  obscu: false,
                  controller: userEmailcon,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyTextField(
                  myText: "enter password",
                  obscu: true,
                  controller: passcon,
                ),
                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  onTap: () {
                  
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage()),
                    );
                  Certs.init();
                  Certs.getEthBalance();
                  Certs.getMyCertsURIs();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'New? Get your web3 Certs wallet',
                        style: TextStyle(),
                      ),
                      TextButton(
                          onPressed: () {
                      
                          },
                          child: Text(
                            "Register Here",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
