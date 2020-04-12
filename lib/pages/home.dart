import 'package:flutter/material.dart';
import 'package:jetpack/pages/menu_about.dart';
import 'package:jetpack/pages/menu_home.dart';
import 'package:jetpack/widgets/responsive_widget.dart';
import 'package:jetpack/util/screen_utils.dart';
import 'package:jetpack/styles/text_styles.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  int _selectedDrawerIndex = 0;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    return Material(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: !ResponsiveWidget.isSmallScreen(context)
              ? (ScreenUtil.getInstance().setWidth(108))
              : (ScreenUtil.getInstance().setWidth(6))),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: _buildTitle(),
          backgroundColor: Color(0xFFf1f3f4),
          actions: !ResponsiveWidget.isSmallScreen(context)
              ? _buildActions(context)
              : null,
          leading: ResponsiveWidget.isSmallScreen(context)
              ? IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                )
              : null,
        ),
        drawer: _buildDrawer(context),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    ));
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: "Jetpack",
            style: TextStyles.logo,
          ),
          TextSpan(
            text: ".net.cn",
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  _buildActions(BuildContext context) {
    return <Widget>[
      MaterialButton(
        child: Text(
          'Home',
          style: TextStyles.menuItem,
        ),
        onPressed: () {
          setState(() {
            _selectedDrawerIndex = 0;
          });
          if (ResponsiveWidget.isSmallScreen(context)) Navigator.pop(context);
        },
      ),
      MaterialButton(
        child: Text(
          'About',
          style: TextStyles.menuItem,
        ),
        onPressed: () {
          setState(() {
            _selectedDrawerIndex = 1;
          });
          if (ResponsiveWidget.isSmallScreen(context)) Navigator.pop(context);
        },
      ),
    ];
  }

  _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: _buildActions(context),
            ),
          )
        : null;
  }

  _getDrawerItemWidget(int selectedDrawerIndex) {
    switch (selectedDrawerIndex) {
      case 0:
        return WidgetMenuHome();
        break;
      case 1:
        return WidgetMenuAbout();
        break;
    }
  }
}
