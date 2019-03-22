import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class GeneralCard extends StatefulWidget
{
  final Widget child;
  final Color color;
  final Color colorDark;
  final bool settles;
  final String title;

  final bool popUpMenuEnabled;
  final PopupMenuButton popUpMenu;

  GeneralCard({this.child, this.color, this.colorDark, this.settles = true, this.title = "Title", this.popUpMenu, this.popUpMenuEnabled =false, Key key}) : super(key:key);

  @override
  State createState() => new GeneralCardState();
}

class GeneralCardState extends State<GeneralCard> with SingleTickerProviderStateMixin
{
  AnimationController _animationController;
  Animation<double> _animation;

  void initState()
  {
    super.initState();

    _animationController = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeIn);

    _animationController.addListener(() => this.setState((){}));

    _animationController.forward();
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
                            widget.title,
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
                    height: 100,
                    width: 100,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(widget.colorDark),
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
              createMenu(message.message);
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
                            "widget.title",
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
                    height: 0,
                    width: 0,
                    child: Opacity(
                      opacity: 0,
                      child: _webView,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: this.content,
                      )
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

  void createMenu(String data)
  {
    // this.setState((){
    //   List list = jso
  }
}