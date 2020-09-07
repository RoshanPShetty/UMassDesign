import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'utils/variables.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _checked = false;
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  signup() {
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailController.text, password: passwordController.text).then((signedInUser) {
      userCollection.doc(signedInUser.user.uid).set({
        'username': usernameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'uid': signedInUser.user.uid,
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[700],
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 150),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "UMass Design",
                style: pacificoStyle(40, Colors.white, FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Register",
                style: robotoStyle(30, Colors.white, FontWeight.w800),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   width: 90,
              //   height: 90,
              //   child: Image.asset('images/Logo.png')
              // ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: usernameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Username',
                      labelStyle: robotoStyle(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Email',
                      labelStyle: robotoStyle(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.email)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Password',
                      labelStyle: robotoStyle(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: Icon(Icons.lock)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => signup(),
                child: Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    "Register",
                    style: robotoStyle(20, Colors.grey[700], FontWeight.w700),
                  )),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CheckboxListTile(
                activeColor: Colors.purple[700],
                controlAffinity: ListTileControlAffinity.leading,
                title: Row(
                  children: <Widget>[
                    Text(
                      "I agree to ",
                      style: robotoStyle(20, Colors.white),
                    ),
                    InkWell(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms())),
                        child: Text(
                          "Umass Design terms",
                          style: robotoStyle(20, Colors.white, FontWeight.bold),
                        )),
                  ],
                ),
                value: _checked,
                onChanged: (bool value) {
                  setState(() {
                    _checked = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
