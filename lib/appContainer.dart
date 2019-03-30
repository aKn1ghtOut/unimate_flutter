import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'util/MenuItem.dart';

import 'ui/navigation/BottomBar.dart';
import 'ui/navigation/TopBar.dart';

import './pages/HomePage.dart';
import './pages/SchedulePage.dart';
import './pages/ShoutBoxPage.dart';
import './pages/FastTrackPage.dart';
import './pages/AttendancePage.dart';


class AppContainer extends StatefulWidget
{
  State createState() => new AppContainerState();
}

class AppContainerState extends State<AppContainer>
{

  Widget inside;

  final Widget 
    homePage = HomePage(key: PageStorageKey("homePage")),
    schedulePage = SchedulePage(key: PageStorageKey("schedulePage")), 
    shoutBoxPage = ShoutBoxPage(key: PageStorageKey("shoutBoxPage")), 
    fastTrackpage = FastTrackPage(key: PageStorageKey("fastTrackPage")), 
    attendancePage = AttendancePage(key: PageStorageKey("attendancePage"));

  @override
  void initState()
  {
    super.initState();
    inside = homePage;
  }

  Widget build(BuildContext context)
  {
    return new SafeArea(
      child: new Material(
        color: Color.fromRGBO(30, 30, 30, 1),
        child: new Column(
          children: <Widget>[
            new TopBar(),
            new Expanded(
              child: new Container(
                child: inside
              ),
            ),
            new BottomBar(
              [
                new MenuItem(
                  FontAwesomeIcons.houzz, 
                  "Home", 
                  () => this.setState(()
                  {
                    inside = homePage;
                  }),
                  Colors.yellow,
                  selected : true
                ),
                new MenuItem(
                  FontAwesomeIcons.calendarWeek, 
                  "Schedule",  
                  () => this.setState(()
                  {
                    inside = schedulePage;
                  }),
                  Colors.blue
                ),
                new MenuItem(
                  FontAwesomeIcons.poll, 
                  "ShoutBox",  
                  () => this.setState(()
                  {
                    inside = shoutBoxPage;
                  }),
                  Colors.purple
                ),
                new MenuItem(
                  FontAwesomeIcons.taxi, 
                  "Fast Track",  
                  () => this.setState(()
                  {
                    inside = fastTrackpage;
                  }),
                  Colors.red
                ),
                new MenuItem(
                  FontAwesomeIcons.handPaper, 
                  "Attendance",  
                  () => this.setState(()
                  {
                    inside = attendancePage;
                  }),
                  Colors.green
                ),
              ]
            )
          ],
        ),
      ),
    );
  }
}