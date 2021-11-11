import 'package:flutter/material.dart';
import 'package:newsapp/helper/news.dart';
import 'package:newsapp/helper/widget.dart';

class Category extends StatefulWidget {
  const Category({Key? key, required this.newsCategory}) : super(key: key);
  final String newsCategory;
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var newslist;
  bool _loading = true;
  @override
  void initState() {
    getNews();
    // TODO: implement initState
    super.initState();
  }

  void getNews() async {
    NewsForCategory news = NewsForCategory();
    await news.getNewsForCategory(widget.newsCategory);
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Flutter",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
            ),
            Text(
              "News",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            )
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(
                  Icons.share,
                )),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: ListView.builder(
                    itemCount: newslist.length,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return NewsTile(
                        imgUrl: newslist[index].urlToImage ?? "",
                        title: newslist[index].title ?? "",
                        desc: newslist[index].description ?? "",
                        content: newslist[index].content ?? "",
                        posturl: newslist[index].articleUrl ?? "",
                      );
                    }),
              ),
            ),
    );
  }
}
