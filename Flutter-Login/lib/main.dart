import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: Home());
  }
}

class AppState {
  bool loading;
  User user;
  AppState(this.loading, this.user);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final app = AppState(false, null);
  @override
  Widget build(BuildContext context) {
    if (app.loading) return _loading();
    if (app.user == null) return _loginPage();
    return _main();
  }

  Widget _loading() {
    return Scaffold(
        appBar: AppBar(
          title: Text("LOADING..."),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ));
  }

  Widget _loginPage() {
    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ID"),
            Text("PASSWORD"),
            RaisedButton(
              child: Text("Login"),
              onPressed: () {
                setState(() {
                  _signIn();
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _main() {
    return Scaffold(
      appBar: AppBar(
        title: Text("app.user"),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              _signOut();
            },
          )
        ],
      ),
      body: Center(
        child: Text("CONTENTS"),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> _signIn() async {
    setState(() => app.loading = true);

    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential googleAuthCredential =
        GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(googleAuthCredential);
    final User user = userCredential.user;
    setState(() {
      app.loading = false;
      app.user = user;
    });
    return "Succese";
  }

  _signOut() async {
    await _googleSignIn.signOut();
    setState(() {
      app.user = null;
    });
  }
}
