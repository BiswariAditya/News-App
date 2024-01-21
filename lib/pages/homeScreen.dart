import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/headlineModels.dart';
import 'package:news_app/View%20Models/newsViewModel.dart';
import 'package:news_app/pages/categoryScreen.dart';
import 'package:news_app/pages/newsDetailScreen.dart';

import '../Models/categoryNewsModels.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat('MM.dd.yyyy');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .sizeOf(context)
        .height * 1;
    final width = MediaQuery
        .sizeOf(context)
        .width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'News',
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        leading: (IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CategoriesScreen()));
            },
            icon: Image.asset(
              'images/category_icon.png',
              height: 23,
              width: 23,
            ))),
      ),
      body: ListView(
        children: [
          Text('   HEADLINES',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 4,
                  fontSize: 15,
                  color: Colors.black54)),
          SizedBox(height: 5),
          SizedBox(
            height: height * 0.45,
            width: width,
            child: FutureBuilder<headlineModels>(
                future: newsViewModel.fetchNewsApi(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailScreen(
                                              newsImage: snapshot
                                                  .data!.articles![index]
                                                  .urlToImage
                                                  .toString(),
                                              newsTitle: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              content:
                                              snapshot.data!.articles![index]
                                                  .content.toString(),
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString())));
                            },
                            child: SizedBox(
                              child:
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: height * 0.5,
                                  width: width * 0.9,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Container(
                                              child: SpinKitCircle(
                                                color: Colors.blueGrey,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Icon(
                                              Icons.error_outline,
                                              color: Colors.red,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 5,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.all(15),
                                      height: height * .16,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight.w700),
                                              )),
                                          Spacer(),
                                          Container(
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w500),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            ),
                          );
                        });
                  }
                }),
          ),
          Text('   GENERAL',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 4,
                  fontSize: 15,
                  color: Colors.black54)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder<CategoriesNewsModel>(
              future: newsViewModel.fetchCategoriesNewsApi('General'),
              builder: (BuildContext context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('not responding');
                  return Center(
                    child: SpinKitCircle(
                      size: 50,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.4,
                    child: ListView.builder(
                      itemCount: snapshot.data!.articles!.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt
                              .toString(),
                        );
                        return Padding(
                          padding:
                          const EdgeInsets.only(bottom: 8.0, top: 10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NewsDetailScreen(
                                              newsImage: snapshot
                                                  .data!.articles![index]
                                                  .urlToImage
                                                  .toString(),
                                              newsTitle: snapshot
                                                  .data!.articles![index].title
                                                  .toString(),
                                              newsDate: snapshot.data!
                                                  .articles![index].publishedAt
                                                  .toString(),
                                              author: snapshot
                                                  .data!.articles![index].author
                                                  .toString(),
                                              description: snapshot.data!
                                                  .articles![index].description
                                                  .toString(),
                                              content:
                                              snapshot.data!.articles![index]
                                                  .content.toString(),
                                              source: snapshot.data!
                                                  .articles![index].source!.name
                                                  .toString())));
                            },
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage
                                        .toString(),
                                    fit: BoxFit.cover,
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.18,
                                    // Set the desired height
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width * 0.3,
                                    // Set the desired width
                                    placeholder: (context, url) =>
                                        Container(
                                          child: SpinKitCircle(
                                            color: Colors.blueGrey,
                                          ),
                                        ),
                                    errorWidget: (context, url, error) =>
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.red,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height *
                                        0.14, // Set the desired height
                                    padding:
                                    EdgeInsets.symmetric(horizontal: 5),
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index]
                                              .title ??
                                              '',
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 9,
                                        ),
                                        Text(
                                          format.format(dateTime),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          snapshot.data!.articles![index].source
                                              ?.name ??
                                              '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
