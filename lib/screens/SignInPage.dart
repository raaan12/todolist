import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'tasksScreen.dart';
import 'SignUpPage.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth =firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool circular = false;


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white54,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo2.png",
                height: 150,
              ),

              Text("Sign In",style: TextStyle(fontSize: 40,color: Colors.teal,fontWeight: FontWeight.bold),
              ),



              SizedBox(height: 15,),
              textItem("Email...",_emailController,false),
              SizedBox(height: 15,),
              textItem("Password...",_pwdController,true),
              SizedBox(height: 30,),
              colorButton(),
              SizedBox(height: 20,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member YET !!! ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize:18,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (builder)=>SignUpPage()),
                              (route) => false);
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              /*

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Not a member YET !!! ",
                    style: TextStyle(
                      color: Colors.black45,
                      fontSize:18,
                    ),
                  ),
                  Text(
                    "SignUp",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

            /*      InkWell(
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (builder)=>SignUpPage()),
                              (route) => false);
                    },
                  ),*/
                ],
              ),*/

              SizedBox(height: 10,),
              Text(
                "Forgot password?",
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget colorButton(){
    return InkWell(
      onTap: () async{
        try {
          firebase_auth.UserCredential userCredential = await firebaseAuth
              .signInWithEmailAndPassword(
              email: _emailController.text,
              password: _pwdController.text);

          print(userCredential.user?.email);
          setState(() {
            circular=false;
          });
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (builder)=>HomePage()),
                  (route) => false);
        }catch(e){

          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
          setState(() {
            circular=false;
          });
        }

      },

      child: Container(
        width: MediaQuery.of(context).size.width - 90,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.teal,
        ),
        child: Center(
            child: circular
                ? CircularProgressIndicator():
            Text("Sign In",
              style: TextStyle(
                color: Colors.black,
                fontSize:20, ),


            )
        ),
      ),
    );
  }

  Widget buttonItem(String imagepath, String buttonName, double size){
    return Container(
      width: MediaQuery.of(context).size.width-60,
      height: 60,
      child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              width: 1,
              color:Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                imagepath,
                height: size,
                width: size,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                buttonName,

                style: TextStyle(
                  color:Colors.black45,
                  fontSize: 17,
                ),
              ),
            ],
          )
      ),

    );

  }


  Widget textItem(
      String labeltext, TextEditingController controller, bool obscureText){
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width - 70 ,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: 17,
          color: Colors.black,
        ),
        decoration: InputDecoration(
            labelText: labeltext,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1.5,
                color:Colors.teal,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                width: 1,
                color:Colors.grey,
              ),
            )
        ),
      ),
    );
  }
}
