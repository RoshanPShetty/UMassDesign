import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';
import 'utils/variables.dart';
import 'signup.dart';

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool signedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((useraccount) {
      if (useraccount != null) {
        setState(() {
          signedIn = true;
        });
      } else {
        setState(() {
          signedIn = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signedIn == false ? Login() : HomePage(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  login() {
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[700],
      body: Container(
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
              "Login",
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
              onTap: () => login(),
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                    child: Text(
                  "Login",
                  style: robotoStyle(20, Colors.grey[700], FontWeight.w700),
                )),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Dont' have an account?",
                  style: robotoStyle(20, Colors.white),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp())),
                    child: Text(
                      "Register",
                      style: robotoStyle(20, Colors.white, FontWeight.bold),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
