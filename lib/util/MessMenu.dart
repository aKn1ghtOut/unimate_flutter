import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';

class MessMenuTabbed extends StatefulWidget
{
  final Color color;
  final Color colorDark;

  final bool popUpMenuEnabled;
  final PopupMenuButton popUpMenu;

  MessMenuTabbed({this.color, this.colorDark, this.popUpMenu, this.popUpMenuEnabled =false, Key key}) : super(key:key);

  @override
  State createState() => new MessMenuTabbedState();
}

class MessMenuTabbedState extends State<MessMenuTabbed> with SingleTickerProviderStateMixin
{
  AnimationController _animationController;
  Animation<double> _animation;

  final String jsTOExecute = 
  'var dh_arr={"dh1":{"breakfast":[],"lunch":[],"dinner":[]},"dh2":{"breakfast":[],"lunch":[],"dinner":[]}};var dh1_ob=\$("section#DH1").find("table > tbody");var dh1_brkfst=dh1_ob.find("td").eq(1);var dh1_lunch=dh1_ob.find("td").eq(2);var dh1_dinner=dh1_ob.find("td").eq(3);dh1_brkfst.find("p").each(function()'+
  '{var item=\$(this).text().trim();dh_arr.dh1.breakfast.push(item)});dh1_lunch.find("p").each(function()'+
  '{var item=\$(this).text().trim();dh_arr.dh1.lunch.push(item)});dh1_dinner.find("p").each(function()'+
  '{var item=\$(this).text().trim();dh_arr.dh1.dinner.push(item)});var dh2_ob=\$("section#DH2").find("table > tbody");var dh2_brkfst=dh2_ob.find("td").eq(1);var dh2_lunch=dh2_ob.find("td").eq(2);var dh2_dinner=dh2_ob.find("td").eq(3);dh2_brkfst.find("p").each(function()' +
  '{var item=\$(this).text().trim();dh_arr.dh2.breakfast.push(item)});dh2_lunch.find("p").each(function()' +
  '{var item=\$(this).text().trim();dh_arr.dh2.lunch.push(item)});dh2_dinner.find("p").each(function()' +
  '{var item=\$(this).text().trim();dh_arr.dh2.dinner.push(item)});';

  WebViewController _webViewController;
  WebView _webView;

  bool hasLoaded = false;

  Widget content;

  void initState()
  {
    super.initState();

    content = Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      child: SizedBox( 
        height: 40,
        width: 40,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(widget.colorDark),
        ),
      ),
    );

    _animationController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.addListener(() => this.setState((){}));

    _animationController.forward();

    _webView = WebView(
      onWebViewCreated: (WebViewController w){
        _webViewController = w;
      },
      initialUrl: "http://messmenu.snu.in/messMenu.php",
      javascriptMode: JavascriptMode.unrestricted,
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: "HTMLOUT",
            onMessageReceived: (JavascriptMessage message){
              print("JS Worked");
              createMenu(message.message);
              hasLoaded = true;
            }
          )
        ]
      ),
      onPageFinished: (String response){
        print("Page finished loading");
        _webViewController.evaluateJavascript("$jsTOExecute HTMLOUT.postMessage(JSON.stringify(dh_arr));");
      },
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Card(
      color: widget.color,
      elevation: 10 * _animation.value,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5)
        )
      ),
      margin: EdgeInsets.fromLTRB(
        10, 
        20 - (10 * _animation.value), 
        10, 
        (10 * _animation.value) + 10
      ),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10
                    ),
                    decoration: BoxDecoration(
                      color: widget.colorDark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)
                      )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Mess Menu",
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        (widget.popUpMenuEnabled ? widget.popUpMenu : Container())
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    width: 1,
                    child: Opacity(
                      opacity: 0,
                      child: _webView,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      this.content,
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void createMenu(String data) async
  {
    print("Function was called");

    Map<String, Map<String, List<String>>> menus = await compute(processJSON, data);

    this.setState(()
    {
      content = Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "DH1",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark
                      ),
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Breakfast",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: menus["dh1"]["breakfast"].map(
                              (String str){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: widget.colorDark,
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark
                                    ),
                                  ),
                                );
                              }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Lunch",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: menus["dh1"]["lunch"].map(
                              (String str){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: widget.colorDark,
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark
                                    ),
                                  ),
                                );
                              }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Dinner",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: menus["dh1"]["dinner"].map(
                              (String str){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: widget.colorDark,
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark
                                    ),
                                  ),
                                );
                              }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "DH2",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark
                      ),
                    )
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Breakfast",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark
                            ),
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: menus["dh2"]["breakfast"].map(
                              (String str){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: widget.colorDark,
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark
                                    ),
                                  ),
                                );
                              }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Lunch",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: menus["dh2"]["lunch"].map(
                              (String str){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: widget.colorDark,
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark
                                    ),
                                  ),
                                );
                              }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Dinner",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Wrap(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            children: menus["dh2"]["dinner"].map(
                              (String str){
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: widget.colorDark,
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                  ),
                                  child: Text(
                                    str,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColorDark
                                    ),
                                  ),
                                );
                              }).toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            )
          ],
        ),
      );
    });
  }

  void noNetwork()
  {}
  
  static Map<String, Map<String, List<String>>> processJSON(String data)
  {
    Map<String, dynamic> dhMenu = json.decode(data);
    Map<String, dynamic> dh1 = dhMenu["dh1"];
    Map<String, dynamic> dh2 = dhMenu["dh2"];

    List<dynamic> dh1Breakfast = List<String>.from(dh1['breakfast']);
    List<dynamic> dh1Lunch = List<String>.from(dh1['lunch']);
    List<dynamic> dh1Dinner = List<String>.from(dh1['dinner']);

    List<dynamic> dh2Breakfast = List<String>.from(dh2['breakfast']);
    List<dynamic> dh2Lunch = List<String>.from(dh2['lunch']);
    List<dynamic> dh2Dinner = List<String>.from(dh2['dinner']);

    Map<String, List<String>> dh1Map = {
      "breakfast" : dh1Breakfast.map((dynamic t){return (t as String);}).toList(),
      "lunch" : dh1Lunch.map((dynamic t){return (t as String);}).toList(),
      "dinner" : dh1Dinner.map((dynamic t){return (t as String);}).toList()
    };
    
    Map<String, List<String>> dh2Map = {
      "breakfast" : dh2Breakfast.map((dynamic t){return (t as String);}).toList(),
      "lunch" : dh2Lunch.map((dynamic t){return (t as String);}).toList(),
      "dinner" : dh2Dinner.map((dynamic t){return (t as String);}).toList()
    };
    
    Map<String, Map<String, List<String>>> menus = {
      "dh1" : dh1Map,
      "dh2" : dh2Map
    };

    return menus;
  }
}