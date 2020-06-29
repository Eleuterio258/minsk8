import 'package:flutter/material.dart';
import 'package:minsk8/import.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navigationBartabIndex = 0;
  int _showcaseTabIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final body = [
      Showcase(
        tabIndex: _showcaseTabIndex,
        onChangeTabIndex: _onChangeShowcaseTabIndex,
      ),
      Underway(),
      Chat(),
      Profile(),
    ];
    return Scaffold(
      drawer: isInDebugMode ? MainDrawer(null) : null,
      body: body[_navigationBartabIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: buildAddButton(
        context,
        getTabIndex: () => _showcaseTabIndex,
      ),
      bottomNavigationBar: NavigationBar(
        tabIndex: _navigationBartabIndex,
        onChangeTabIndex: _onChangeNavigationBarTabIndex,
      ),
      extendBody: true,
    );
  }

  void _onChangeNavigationBarTabIndex(int tabIndex) {
    setState(() {
      _navigationBartabIndex = tabIndex;
    });
  }

  void _onChangeShowcaseTabIndex(int tabIndex) {
    _showcaseTabIndex = tabIndex;
  }
}
