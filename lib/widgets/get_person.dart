import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_review/bloc/get_person_bloc.dart';
import 'package:movie_review/models/person_response.dart';
import 'package:movie_review/models/person.dart';
import 'package:movie_review/style/theme.dart';

class Person extends StatefulWidget {
  @override
  _PersonState createState() => _PersonState();
}

class _PersonState extends State<Person> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    personBloc.getPerson();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Trending Person This Week',
            style: TextStyle(
                color: ColorsFix.titleColor,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          StreamBuilder(
              stream: personBloc.subject.stream,
              builder: (context, AsyncSnapshot<PersonResponse> snapshot) {
                if (snapshot.hasData) {
                  return _buildHome(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrorWidget(snapshot.error);
                } else {
                  return _buildLoadingWidget();
                }
              })
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHome(PersonResponse data) {
    List<PersonModel> person = data.persons;
    if (person.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[Text('No Person trending')],
        ),
      );
    } else {
      return Container(
        height: 116,
        child: ListView.builder(
            itemCount: person.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      person[index].profileImg == null
                          ? Container()
                          : Column(
                              children: <Widget>[
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            'https://image.tmdb.org/t/p/w200' +
                                                person[index].profileImg),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(height: 8,),
                                Text(
                                  person[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ],
                            )
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
