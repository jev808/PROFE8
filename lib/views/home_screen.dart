import 'package:flutter/material.dart';
import 'booking_form_screen.dart';
import 'service_request_form_screen.dart';
import 'tracking_form_screen.dart';
import 'local_list_form_screen.dart';
import '../widgets/custom_drawer.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    // Only allow Home tab (index 0) to be selected
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Widget _buildHomeTabContent() {
    return Column(
      children: [
        const SizedBox(height: 32),
        const Text('Welcome to Locksmith Services', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Switch to Services tab (tab index 1)
            _tabController.animateTo(1);
          },
          child: const Text('Go to Services'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BookingFormScreen()),
            );
          },
          child: const Text('Book Appointment'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ServiceRequestFormScreen()),
            );
          },
          child: const Text('Request Locksmith Service'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TrackingFormScreen()),
            );
          },
          child: const Text('Track Locksmith Requests'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LocalListFormScreen()),
            );
          },
          child: const Text('Local List Form Example'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;
    if (_selectedIndex == 0) {
      // Home tab: show TabBar and TabBarView
      bodyContent = Column(
        children: [
          // AppBar bottom: TabBar
          Material(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Services'),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SingleChildScrollView(child: _buildHomeTabContent()),
                const Center(child: Text('Services Tab Content', style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
        ],
      );
    } else if (_selectedIndex == 1) {
      // Profile tab: show TabBar with three tabs (Chats, Status, Calls)
      final TabController profileTabController = TabController(length: 3, vsync: this);
      bodyContent = Column(
        children: [
          Material(
            color: Theme.of(context).primaryColor,
            child: TabBar(
              controller: profileTabController,
              tabs: const [
                Tab(text: 'Chats'),
                Tab(text: 'Status'),
                Tab(text: 'Calls'),
              ],
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white70,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: profileTabController,
              children: const [
                Center(child: Text('Chats Content', style: TextStyle(fontSize: 20))),
                Center(child: Text('Status Content', style: TextStyle(fontSize: 20))),
                Center(child: Text('Calls Content', style: TextStyle(fontSize: 20))),
              ],
            ),
          ),
        ],
      );
    } else {
      bodyContent = const Center(child: Text('Settings Content', style: TextStyle(fontSize: 20)));
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('Locksmith Services'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        showUnselectedLabels: true,
      ),
    );
  }
}
