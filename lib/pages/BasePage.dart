import 'package:flutter/material.dart';

class BasePage extends StatelessWidget
{
  final String title;
  final Color themeColor;
  final Widget inside;
  final VoidCallback onReload;
  final VoidCallback buttonCall;
  final IconData icon;

  BasePage(this.title, this.themeColor, this.inside, {this.onReload, this.icon, this.buttonCall});

  Widget build(BuildContext context)
  {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: RefreshIndicator(
        displacement: 60,
        onRefresh: this.onReload,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(30, 10, 10, 10),
              margin: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      this.title,
                      style: new TextStyle(
                        color: this.themeColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ),
                  (this.icon != null ? IconButton(
                    onPressed: () => buttonCall(),
                    icon: Icon(
                      this.icon,
                      color: this.themeColor,
                      size: 20,
                    ),
                  ) : Container())
                ]
              )
            ),
            this.inside
          ],
        ),
      )
    );
  }
}