import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/Models/categoryNewsModels.dart';
import 'package:news_app/View%20Models/newsViewModel.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat('MM.dd.yyyy');
  String categoryName = 'general';

  List<String> categoryList = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology',
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            buildCategoryList(height, width),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fetchCategoriesNewsApi(categoryName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.black,
                      ),
                    );
                  } else {
                    return buildArticleList(height, width, snapshot);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryList(double height, double width) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return buildCategoryButton(index);
        },
      ),
    );
  }

  Widget buildCategoryButton(int index) {
    return InkWell(
      onTap: () {
        categoryName = categoryList[index];
        setState(() {});
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          decoration: BoxDecoration(
            color: categoryName == categoryList[index]
                ? Colors.blue
                : Colors.grey,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Center(
              child: Text(
                categoryList[index],
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildArticleList(
      double height, double width, AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data!.articles!.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
          child: Row(
            children: [
              buildArticleImage(snapshot, index, height, width),
              buildArticleDetails(snapshot, index, height),
            ],
          ),
        );
      },
    );
  }

  Widget buildArticleImage(AsyncSnapshot snapshot, int index, double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: CachedNetworkImage(
        imageUrl: snapshot.data!.articles![index].urlToImage.toString(),
        fit: BoxFit.cover,
        height: height * .18,
        width: width * .3,
        placeholder: (context, url) => buildLoadingSpinner(),
        errorWidget: (context, url, error) => Icon(
          Icons.error_outline,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget buildArticleDetails(AsyncSnapshot snapshot, int index, double height) {
    return Expanded(
      child: Container(
        height: height * .14,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            buildArticleTitle(snapshot, index),
            SizedBox(height: 9),
            buildArticleDate(snapshot, index),
            buildArticleSource(snapshot, index),
          ],
        ),
      ),
    );
  }

  Widget buildArticleTitle(AsyncSnapshot snapshot, int index) {
    return Text(
      snapshot.data!.articles![index].title.toString(),
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: 15,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget buildArticleDate(AsyncSnapshot snapshot, int index) {
    DateTime dateTime = DateTime.parse(
      snapshot.data!.articles![index].publishedAt.toString(),
    );

    return Text(
      format.format(dateTime),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildArticleSource(AsyncSnapshot snapshot, int index) {
    return Text(
      snapshot.data!.articles![index].source!.name.toString(),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget buildLoadingSpinner() {
    return SpinKitCircle(
      size: 50,
      color: Colors.black,
    );
  }
}
