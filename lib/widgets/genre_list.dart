import 'package:flutter/material.dart';
import 'package:movie_review/models/genre.dart';
import 'package:movie_review/style/theme.dart';
import 'package:movie_review/widgets/genre_movies.dart';
import 'package:movie_review/widgets/genres.dart';

class GenreList extends StatefulWidget {
  List<Genre> genres;

  GenreList(this.genres);
  @override
  _GenreListState createState() => _GenreListState(genres);
}

class _GenreListState extends State<GenreList>
    with SingleTickerProviderStateMixin {
  List<Genre> genres;
  TabController tabController;
  _GenreListState(this.genres);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: genres.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 307,
      child: DefaultTabController(
        length: genres.length,
        child: Scaffold(
          backgroundColor: ColorsFix.mainColor,
          appBar: PreferredSize(
            child: AppBar(
              backgroundColor: ColorsFix.mainColor,
              bottom: TabBar(
                  controller: tabController,
                  indicatorColor: ColorsFix.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  isScrollable: true,
                  tabs: genres.map((Genre genre) {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        genre.name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList()),
            ),
            preferredSize: Size.fromHeight(50),
          ),
          body: TabBarView(
            controller: tabController,
            physics: NeverScrollableScrollPhysics(),
            children: genres.map((Genre genre){
              return Genremovies(genre.id);
            }).toList(),
        )),
      ),
    );
  }
}
