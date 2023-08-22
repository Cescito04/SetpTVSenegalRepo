import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sept_tv/models/apiSubCategory.dart';
import 'package:sept_tv/screens/categoryReplay.dart';
import 'package:sept_tv/screens/lecteur_category.dart';
import 'package:http/http.dart' as http;
import 'package:sept_tv/screens/shimmer.dart';

class CategoryDetails extends StatefulWidget {
  CategoryDetails({super.key, this.getUrl});

  String? getUrl;

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var _isLoading = false;
  ApiSubCategory? datum4;

  Future<ApiSubCategory?> fetchApiSubCategory() async {
    final response = await http.get(Uri.parse(widget.getUrl!));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum4 = ApiSubCategory.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      //print(response.body);
      print("Api Category");
      log('${datum4!.allitems?[0].videoUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  void initState() {
    super.initState();
    fetchApiSubCategory();
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
                  return CategoryReplay();
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
      body:_isLoading
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
                    itemCount: datum4?.allitems?.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 30),
                    itemBuilder: (context, index) {
                      if (datum4 != null &&
                          datum4!.allitems != null &&
                          index < datum4!.allitems!.length) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return LectCategory(
                                getRealated:
                                    datum4!.allitems![index].relatedItems,
                                getVidurl: datum4!.allitems![index].videoUrl,
                                getTitle: datum4!.allitems![index].title,
                                getHour: datum4!.allitems![index].time,
                              );
                            }));
                          },
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
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
                                  '${datum4!.allitems![index].logo}',
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
                                    ' ${datum4!.allitems![index].title}',
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
            )
          : ShimmerList(),
    );
  }
}
