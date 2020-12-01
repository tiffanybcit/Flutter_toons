import 'package:flutter/material.dart';
import 'dart:async';
import 'student.dart';
import 'helper.dart';

void main() => runApp(
      MaterialApp(
        home: Home(
          title: 'Student Navigation demo home page',
          students: new Helper().fetchStudents(),
        ),
      ),
    );

class Home extends StatelessWidget {
  final String title;
  final Future<List<Student>> students;

  Home({Key key, this.title, this.students}) : super(key: key);

  // final items = Student.getStudents();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.grey[850],
            title: Text("Toons by Yi Wen Gu")),
        backgroundColor: Colors.grey[900],
        body: Center(
          child: FutureBuilder<List<Student>>(
            future: students,
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? StudentBoxList(items: snapshot.data)

                  // return the ListView widget :

                  : Center(child: CircularProgressIndicator());
            },
          ),
        ));
  }
}

class StudentBoxList extends StatelessWidget {
  final List<Student> items;

  StudentBoxList({Key key, this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: StudentBox(item: items[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentDetails(item: items[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class StudentDetails extends StatelessWidget {
  StudentDetails({Key key, this.item}) : super(key: key);
  final Student item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.firstName + " " + this.item.lastName),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "ID: ${this.item.personId}",
                              // style: TextStyle(fontWeight: FontWeight.bold)
                            ),
                            Text("First Name: ${this.item.firstName}"),
                            Text("Last Name: ${this.item.lastName}"),
                            Text("Occupation: ${this.item.occupation}"),
                            Image.network(
                              this.item.pictureURL,

                            ),
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}

class StudentBox extends StatelessWidget {
  StudentBox({Key key, this.item}) : super(key: key);
  final Student item;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          color: Colors.grey[800],
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Text(
                                  this.item.personId.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.amber),
                                )),
                            new Container(
                              // flex: 1,
                              // padding: new EdgeInsets.only(left: 8.0),
                              child: new Container(
                                width: 50,
                                child: Image.network(
                                  this.item.pictureURL,
                                  width: 50,
                                ),
                              ),

                              // height: 100,
                              // width: 50,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    new Container(
                                      child: Text(
                                        "${this.item.firstName} ${this.item.lastName}",
                                        style:
                                            TextStyle(color: Colors.deepOrange),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    new Container(
                                      child: Text(
                                        this.item.occupation,
                                        style:
                                            TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                // ),
              ]),
        ));
  }
}
