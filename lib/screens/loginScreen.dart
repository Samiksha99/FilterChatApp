import 'package:flutter/material.dart';
import 'package:funchat/services/authentication.dart';
import 'package:funchat/utilis/dimensions.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var vpH = getViewportHeight(context);
    var vpW = getViewportWidth(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
            children: [
              Container(
                width: double.infinity,
                height: vpH*0.7,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                  ),
                    color: Colors.cyan[600],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        offset: Offset(0, -5),
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                child: Center(child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Filter", style: TextStyle(color: Colors.black, fontSize: vpH*0.07,fontWeight:FontWeight.bold)),
                    Text("Chat", style: TextStyle(color: Colors.white,fontSize: vpH*0.07),),
                  ],
                )),
              ),
              
                Padding(
                  padding: EdgeInsets.only(top:vpH*0.07),
                  child:InkWell(
                      child: Container(
                          width: vpW*0.7,
                          height: vpH*0.07,
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.cyan),
                              color: Colors.cyan[100],
                              boxShadow:[BoxShadow(
                                offset: const Offset(3.0, 3.0),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                                color: Colors.cyan[400]),]
                          ),
                          child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Container(
                                    height: vpH*0.04,
                                    width: vpW*0.06,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                          AssetImage('assets/google.png'),
                                          fit: BoxFit.cover),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Text('Sign in with Google',
                                    style: TextStyle(
                                        fontSize: vpH*0.025,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.cyan[900]
                                    ),
                                  ),
                                ],
                              )
                          )
                      ),
                      onTap: ()=>Authentication.handleLogin()
                    ),
                ),
            ],
      )
    );
  }
}