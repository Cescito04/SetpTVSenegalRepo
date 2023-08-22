import 'package:flutter/material.dart';
import 'home.dart';

class A_propos extends StatefulWidget {
  const A_propos({super.key});

  @override
  State<A_propos> createState() => _A_proposState();
}

class _A_proposState extends State<A_propos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff007CD3),
        leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) {
                  return HomePage();
                }),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Image.asset(
            'assets/logo.png',
            height: 40,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/bg2.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Image.asset('assets/logo.png'),
              ),
              Container(
                height: 230,
                width: 320,
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      '''
7TV est une chaîne généraliste avec un accent particulier sur l’info et le divertissement. Pour la première fois au Sénégal, une chaîne de télévision va explorer le domaine de l’infotainement (Information et divertissement). 
7TV sera diffusée sur l'ensemble du territoire national en hertzien et en numérique via le canal de la TNT.  ''',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Développé par',
                    style: TextStyle(color: Color(0xff009BF1), fontSize: 16),
                  ),
                  Text("     "),
                  Text(
                    'aCAN Group',
                    style: TextStyle(
                        color: Color(0xff007CD3),
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
