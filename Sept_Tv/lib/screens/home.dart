import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sept_tv/models/apiAlaUne.dart';
import 'package:sept_tv/screens/categoryReplay.dart';
import 'package:sept_tv/screens/lecteur_replay.dart';
import 'package:sept_tv/screens/live_tv.dart';
import 'package:sept_tv/screens/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sept_tv/screens/replayTv.dart';
import 'package:sept_tv/screens/youtube_grid.dart';
import '../models/apiseptTv.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiSeptTv? data;

  Future<ApiSeptTv?> fetchApiSeptTV() async {
    final response =
        await http.get(Uri.parse('https://7tv.acangroup.org/myapi/appdetails'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        data = ApiSeptTv.fromJson(jsonDecode(response.body));
      });
      //print(response.body);
      print("Api sept Tv");
      log('${data?.wALFTVAPI?[0].appDataUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  ApiAlaUne? datum1;

  Future<ApiAlaUne?> fetchApiAlaUne() async {
    final response = await http
        .get(Uri.parse('https://7tv.acangroup.org/myapi/alaune/json'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum1 = ApiAlaUne.fromJson(jsonDecode(response.body));
      });
      //print(response.body);
      print("Api à la Une");
      log('${datum1!.allitems?[0].videoUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApiSeptTV();
    fetchApiAlaUne();
  }

  @override
  Widget build(BuildContext context) {
    //log('${data?.wALFTVAPI?[0].appDataUrl}');
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      drawer: NavBar(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 35.0),
                  child: SizedBox(
                    child: Container(
                      child: Stack(
                        children: [
                          Image.asset('assets/entete.png'),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Center(
                              child: Image.asset(
                                'assets/logo.png',
                                height: 64,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            left: 0,
                            right: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'LA TÉLÉ QUI NOUS RESSEMBLE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  'ET NOUS RASSEMBLE',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ),
                          Builder(
                              builder: (context) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, top: 10.0),
                                    child: IconButton(
                                      onPressed: () =>
                                          Scaffold.of(context).openDrawer(),
                                      icon: Icon(
                                        Icons.menu,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return DirectTv();
                        }));
                      },
                      child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.live_tv_outlined,
                                color: Color(0xff007CD3),
                                size: 60,
                              ),
                              Text(
                                'Direct',
                                style: TextStyle(
                                    color: Color(0xff007CD3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return YouTube();
                        }));
                      },
                      child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/youtubeIcon.png',
                                  color: Color(0xff007CD3)),
                              Text(
                                'YouTube',
                                style: TextStyle(
                                    color: Color(0xff007CD3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryReplay();
                        }));
                      },
                      child: Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Image.asset('assets/replayImg.png',
                                  color: Color(0xff007CD3)),
                              Text(
                                'Replay',
                                style: TextStyle(
                                    color: Color(0xff007CD3),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Container(
                          height: 40,
                          width: 5,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Dernières vidéos',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 138.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ReplayTv();
                                },
                              ),
                            );
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 340,
                  child: CustomScrollView(
                   physics: NeverScrollableScrollPhysics(),
                    slivers: [
                      SliverPadding(
                        padding: EdgeInsets.all(20),
                        sliver: SliverGrid(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 30,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              // Perform a null check on datum1 before accessing allitems
                              if (datum1 != null &&
                                  datum1!.allitems != null &&
                                  index < datum1!.allitems!.length) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return LectReplay(
                                            getVidUrl:
                                                datum1!.allitems![index].videoUrl,
                                            getRelated: datum1!
                                                .allitems![index].relatedItems,
                                            getTitle: datum1!.allitems![index].title,
                                            getTime: datum1!.allitems![index].time,
                                            index: index,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 100,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xffFFFFFF), width: 4),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                              '${datum1!.allitems![index].logo}',
                                              placeholder: (context, url) =>
                                                  Image.asset('assets/imgCache.png'),
                                              errorWidget: (context, url, error) =>
                                                  Image.asset('assets/imgCache.png',fit: BoxFit.cover,),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                           Transform.translate(
                                             offset: Offset(100, 50),
                                               child: Icon(Icons.play_circle_fill_outlined,size: 40.0,color: Color(0xff007CD3),)
                                           ),
                                        ],
                                      ),

                                      Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        ' ${datum1!.allitems![index].title}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                // Handle the case when datum1 or allitems is null
                                return Container(
                                  height: 100,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xffFFFFFF), width: 4),
                                  ),
                                  child: Image.asset('assets/imgCache.png',
                                      fit: BoxFit.cover),
                                ); // or any other placeholder widget
                              }
                            },
                            childCount:
                                4, // Use the null-aware operator here as well
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ),
        
      ),
    );
  }
}
