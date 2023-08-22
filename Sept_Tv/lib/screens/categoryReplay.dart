import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sept_tv/models/apiCategory.dart';
import 'package:sept_tv/screens/detailsCategory.dart';
import 'package:sept_tv/screens/home.dart';
import 'package:http/http.dart' as http;
import 'package:sept_tv/screens/shimmer.dart';

class CategoryReplay extends StatefulWidget {
  const CategoryReplay({super.key});

  @override
  State<CategoryReplay> createState() => _CategoryReplayState();
}

class _CategoryReplayState extends State<CategoryReplay> {
  var _isLoading = false;
  ApiCategory? datum3;

  Future<ApiCategory?> fetchApiCategory() async {
    final response = await http
        .get(Uri.parse('https://7tv.acangroup.org/myapi/listChannels/json'));
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

  @override
  void initState() {
    super.initState();
    fetchApiCategory();
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
          ?
      Container(
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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                    // shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: datum3?.allitems?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: 30),
                    itemBuilder: (context, index) {
                      if (datum3 != null &&
                          datum3!.allitems != null &&
                          index < datum3!.allitems!.length) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return CategoryDetails(
                                getUrl: datum3!.allitems?[index].feedUrl,
                              );
                            }));
                          },
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: 110,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xffFFFFFF), width: 4),
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
                                    ' ${datum3!.allitems![index].title}',
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
                          height: 100,
                          width: 200,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Color(0xffFFFFFF), width: 4),
                          ),
                          child: Image.asset('assets/imgCache.png',
                              fit: BoxFit.cover),
                        );
                      }
                    }),
              )),
            ):ShimmerList()

    );
  }
}
