import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPage();
  }
}

class LoginPage extends State<Login> {
  _fetchData() async {
    print("Connecting to network");
    final url = "http://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(response.body);
    }
    final map = json.decode(response.body);
    final vdo = map["videos"];
    // vdo.forEach((video){
    //   print(video["name"]);
    // });
    setState(() {
      _isLoading = false;
      this.list = vdo;
    });
  }

  var list;
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Hello"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              _fetchData();
            },
          )
        ],
      ),
      body: new Center(
        child: _isLoading
            ? new CircularProgressIndicator()
            : new ListView.builder(
                itemCount: this.list != null ? this.list.length : 0,
                itemBuilder: (context, i) {
                  final video = this.list[i];
                  return new FlatButton(
                    padding: EdgeInsets.all(0.0),
                    child: new VdoPage(video),
                    onPressed: (){
                      Navigator.push(context, 
                        new MaterialPageRoute(
                          builder: (context) => new DetailPage()
                        )
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

class VdoPage extends StatelessWidget {
  final video;
  VdoPage(this.video);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Column(
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(16.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.network(video["imageUrl"]),
              new Container(
                height: 8.0,
              ),
              new Text(
                video["name"],
                style:
                    new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        new Divider(),
      ],
    );
  }
}
class DetailPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Detail"),
      ),
      body: new Center(
        child: new Text("hello,world"),
      ),
    );
  }
}
