import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sept_tv/screens/shimmer.dart';
import '../models/apiSubCategory.dart';

class LectCategory extends StatefulWidget {
  LectCategory(
      {super.key,
      this.getRealated,
      this.getVidurl,
      this.getHour,
      this.getTitle,
      this.index});

  String? getRealated;
  String? getVidurl;
  String? getTitle;
  String? getHour;
  var index;

  @override
  State<LectCategory> createState() => _LectCategoryState();
}

class _LectCategoryState extends State<LectCategory> {
  var video;
  var related;
  var time;
  var title;
  var _isLoading =false;
  ApiSubCategory? datum4;

  Future<ApiSubCategory?> fetchApiSubCategory() async {
    final response = await http.get(Uri.parse(widget.getRealated!));
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        datum4 = ApiSubCategory.fromJson(jsonDecode(response.body));
        _isLoading = true;
      });
      BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
          BetterPlayerDataSourceType.network, video!);
      _betterPlayerController = BetterPlayerController(
          BetterPlayerConfiguration(autoPlay: true),
          betterPlayerDataSource: betterPlayerDataSource);
      //print(response.body);
      print("Api Category");
      // log('${datum4!.allitems?[0].videoUrl}');
    } else {
      throw Exception('Failed to load ApiSeptTv');
    }
  }

  BetterPlayerController? _betterPlayerController;

  void initState() {
    super.initState();
    fetchApiSubCategory();
    setState(() {
      video=widget.getVidurl;
      log("initVideo ${video}");
      related=widget.getRealated;
      log("initRelated ${related}");
      time=widget.getHour;
      title=widget.getTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff007CD3),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height + 600,
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: BetterPlayer(
                          controller: _betterPlayerController!,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 28.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              Text(
                                time,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                                'Videos Similaires',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ],
                        ),


                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: CustomScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.all(20),
                                sliver: SliverGrid(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 30,
                                  ),
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      // log('messageLog VideoUrl ${datum4!.allitems![index].videoUrl}');
                                      if (datum4 != null &&
                                          datum4!.allitems != null &&
                                          index < datum4!.allitems!.length) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {

                                              video = datum4!
                                                  .allitems![index].videoUrl;
                                              log('Video ${video}');
                                              related = datum4!
                                                  .allitems![index]
                                                  .relatedItems;
                                              log('related ${related}');
                                              title =  datum4!
                                                  .allitems![index].title;
                                              log("title ${title}");
                                              time =   datum4!
                                                  .allitems![index].time;
                                              log("time${time}");
                                              fetchApiSubCategory();

                                              widget.index=index;
                                            });
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
                                                  color: widget.index==index ? Color(0xffFFFFFF):Colors.transparent, width: 4),
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
                                        );
                                      } else {
                                        return CircularProgressIndicator();
                                      }
                                    },
                                    childCount: datum4?.allitems?.length ?? 0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : ShimmerList(),
    );
  }
}
