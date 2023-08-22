import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sept_tv/screens/home.dart';
import 'package:sept_tv/screens/lecteur_replay.dart';
import 'package:http/http.dart' as http;
import 'package:sept_tv/screens/shimmer.dart';
import '../models/apiAlaUne.dart';

class ReplayTv extends StatefulWidget {
  const ReplayTv({super.key});

  @override
  State<ReplayTv> createState() => _ReplayTvState();
}

class _ReplayTvState extends State<ReplayTv> {
  var _isLoading = false;
  ApiAlaUne? datum2;

  Future<ApiAlaUne?> fetchApiAlaUne() async {
    final response = await http
        .get(Uri.parse('https://7tv.acangroup.org/myapi/alaune/json'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum2 = ApiAlaUne.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      //print(response.body);
      print("Api Replay");
      log('${datum2!.allitems?[0].videoUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  @override
  void initState() {
    super.initState();
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
      body: _isLoading
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg1.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: datum2?.allitems?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 30),
                    itemBuilder: (context, index) {
                      if (datum2 != null &&
                          datum2!.allitems != null &&
                          index < datum2!.allitems!.length) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LectReplay(
                                getVidUrl: datum2!.allitems![index].videoUrl,
                                getRelated:
                                    datum2!.allitems![index].relatedItems,
                                getTitle: datum2!.allitems![index].title,
                                getTime: datum2!.allitems![index].time,
                                index: index,
                              );
                            }));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SingleChildScrollView(
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
                                          '${datum2!.allitems![index].logo}',
                                          placeholder: (context, url) =>
                                              Image.asset('assets/imgCache.png'),
                                          errorWidget: (context, url, error) =>
                                              Image.asset('assets/imgCache.png'),
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
                                    ' ${datum2!.allitems![index].title}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                            height: 110,
                            width: 200,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xffFFFFFF), width: 4),
                            ),
                            child: Image.asset(
                              'assets/imgCache.png',
                              fit: BoxFit.cover,
                            ));
                      }
                    }),
              )),
            )
          :ShimmerList(),
    );
  }
}
