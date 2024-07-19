import 'package:flutter/material.dart';
import 'package:custom_pull_to_refresh_app/models/item_model.dart';
import 'package:custom_pull_to_refresh_app/widgets/custom_refresh_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// HomeScreen is the main screen of the app, displaying a list of items
/// with a custom pull-to-refresh feature and a TabBar to switch between different tabs.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // List of items to be displayed in the ListView
  List<Item> items = List.generate(20, (index) => Item(title: 'Item $index'));

  // TabController to manage the TabBar and TabBarView
  late TabController _tabController;

  // List of RefreshControllers, one for each tab
  late List<RefreshController> _refreshControllers;

  @override
  void initState() {
    super.initState();
    // Initialize the TabController with 3 tabs
    _tabController = TabController(length: 3, vsync: this);

    // Initialize RefreshControllers for each tab
    _refreshControllers = List.generate(3, (index) => RefreshController(initialRefresh: false));
  }

  /// Function to handle refresh action
  /// Simulates a network call and updates the items list
  void _onRefresh(int index) async {
    await Future.delayed(Duration(milliseconds: 1000));
    setState(() {
      items = List.generate(20, (index) => Item(title: 'New Item $index'));
    });
    // Complete the refresh action
    _refreshControllers[index].refreshCompleted();
  }

  @override
  void dispose() {
    // Dispose the TabController
    _tabController.dispose();

    // Dispose each RefreshController
    for (var controller in _refreshControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with title, action icon, and TabBar
      appBar: AppBar(
        title: Text(
          'Pull to Refresh App',
          style: GoogleFonts.lato(),
        ),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.syncAlt, color: Colors.white),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ],
        ),
      ),
      // TabBarView to display content for each tab
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(0),
          _buildTabContent(1),
          _buildTabContent(2),
        ],
      ),
    );
  }

  /// Builds the content for each tab
  /// Uses CustomRefreshIndicator with a ListView
  Widget _buildTabContent(int index) {
    return CustomRefreshIndicator(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].title),
          );
        },
      ),
      refreshController: _refreshControllers[index],
      onRefresh: () => _onRefresh(index),
    );
  }
}
