import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sept_tv/models/apiDirect.dart';
import 'package:sept_tv/screens/detailsCategory.dart';
import 'package:sept_tv/screens/home.dart';
import 'package:better_player/better_player.dart';
import 'package:sept_tv/screens/lecteur_replay.dart';
import 'package:sept_tv/screens/replayTv.dart';
import 'package:http/http.dart' as http;
import 'package:sept_tv/screens/shimmer.dart';
import '../models/apiAlaUne.dart';
import '../models/apiCategory.dart';
import 'categoryReplay.dart';
import 'package:shimmer/shimmer.dart';

class DirectTv extends StatefulWidget {
  const DirectTv({super.key});

  @override
  State<DirectTv> createState() => _DirectTvState();
}

class _DirectTvState extends State<DirectTv> {
  var _isLoading =false;

  BetterPlayerController? _betterPlayerController;


  ApiDirect? datum4;
  Future<ApiDirect?> fetchApiDirect() async {
    final response = await http.get(Uri.parse('https://7tv.acangroup.org/myapi/listLiveTV/json'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum4 = ApiDirect.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      // Create a BetterPlayerDataSource using the stream URL
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        liveStream:true,
        BetterPlayerDataSourceType.network,
        "${datum4?.allitems?[0].streamUrl}",
      );

      // Initialize the BetterPlayerController with the configuration and data source
      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
        ),
        betterPlayerDataSource: betterPlayerDataSource,
      );
      //print(response.body);
      print("Api Live");
     log('${datum4!.allitems?[0].streamUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }


  ApiCategory? datum3;
  Future<ApiCategory?> fetchApiCategory() async {
    final response = await http.get(
        Uri.parse('https://7tv.acangroup.org/myapi/listChannels/json'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum3 = ApiCategory.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      //print(response.body);
      print("Api Category");
      log('${datum3!.allitems?[0].feedUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }
  ApiAlaUne? datum1;
  Future<ApiAlaUne?> fetchApiAlaUne() async {
    final response = await http.get(
        Uri.parse('https://7tv.acangroup.org/myapi/alaune/json'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum1 = ApiAlaUne.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      //print(response.body);
      print("Api à la Une");
     // log('${datum1!.allitems?[0].videoUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchApiDirect();
    fetchApiCategory();
    fetchApiAlaUne();
  }



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
            child: Icon(Icons.arrow_back,
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


      body:_isLoading ?  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg1.png'),
            fit: BoxFit.fill,
          ),
        ),


        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child:// _betterPlayerController != null
                  BetterPlayer(controller: _betterPlayerController!)
                 // : Center(child: CircularProgressIndicator()),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('${datum4!.allitems![0].desc}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),),
                  Text(' - ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                  Text('${datum4!.allitems![0].title}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),)
                ],
              ),
            ),


            SizedBox(height: 20,),
            Container(
              child: Transform.translate(
                offset: Offset(0, -15),
                child: Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Container(
                        height: 30,
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
                            fontSize: 18
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return ReplayTv();
                            }
                        )
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 138.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Container(
              height: 170,
            //  width: 500,
              child: ListView.separated(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => SizedBox(width: 10),
                itemBuilder: (context, index) {
                  if (datum1 != null && datum1!.allitems != null) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return LectReplay(
                              getVidUrl: datum1!.allitems![index].videoUrl,
                              getRelated: datum1!.allitems![index].relatedItems,
                              getTitle: datum1!.allitems![index].title,
                              getTime: datum1!.allitems![index].time,
                              index: index,
                            );
                          }),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Transform.translate(
                          offset: Offset(0,-10),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 160,
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
                                          Image.asset('assets/imgCache.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Transform.translate(
                                      offset: Offset(110, 50),
                                      child: Icon(Icons.play_circle_fill_outlined,size: 40.0,color: Color(0xff007CD3),)
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                child:  SizedBox(
                                    width:160,
                                    child: Text(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      '${datum1!.allitems![index].title}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container(); // Return an empty container or placeholder when data is null
                  }
                },
              ),
            ),


            //SizedBox(height: 20,),
            Transform.translate(
              offset: Offset(0,-20),

                child: Row(

                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 28.0),
                      child: Container(
                        height: 22,
                        width: 5,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Programmes',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                              return CategoryReplay();
                            }
                        )
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 138.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),

            ),

           // SizedBox(height: 20,),

            Expanded(
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    if (datum3 != null && datum3!.allitems != null) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return CategoryDetails(
                                getUrl: datum3!.allitems![index].feedUrl,
                              );
                            }),
                          );
                        },
                       
                          child: Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Transform.translate(
                                offset: Offset(0, -10),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 91,
                                      width: 160,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Color(0xffFFFFFF), width: 4),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: '${datum3!.allitems![index].logo}',
                                        placeholder: (context, url) =>
                                            Image.asset('assets/imgCache.png'),
                                        errorWidget: (context, url, error) =>
                                            Image.asset('assets/imgCache.png'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      '${datum3!.allitems![index].title}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                      );
                    } else {
                      return Container(); // Return an empty container or placeholder when data is null
                    }
                  },
                ),

            ),




          ],
        ),
      ):Center(
        child: ShimmerList(),
      )
    );
  }

}



