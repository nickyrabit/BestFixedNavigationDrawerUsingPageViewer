import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_fixed_menu/drawer_screens/dashboard.dart';
import 'package:material_design_fixed_menu/drawer_screens/help.dart';
import 'package:material_design_fixed_menu/drawer_screens/settings.dart';

// initiating variables for this indexes and paging
var _selectedPageIndex = 0;
List<Widget> _pages = [
  // it is important to keep these indices number so you will find it easier to reference them when you want to open them
  // position 0 as from the array
  DashboardScreen(),
  // position 1`as from the array
  HelpScreen(),
  // position 2 as from the array
  SettingsScreen(),
];

PageController _pageController =
    PageController(initialPage: _selectedPageIndex);

Controller c = Get.put(Controller());

void main() {
  runApp(const MyApp());
}

class Controller extends GetxController {
  // making the variable observable to be able to change it when new screen is opened
  var title = "Dashboard".obs;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // We shall index the pages according to their positions on the array
    _selectedPageIndex = 0;
    // initiating a page controller
    _pageController = PageController(initialPage: _selectedPageIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //dispose the pagecontroller
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Obx(() => Text("${c.title.value}"))),
      // this is our main tool PageView
      // we need to stop it from scrolling with NeverScrollableScrollPhysics()
      // we need to list all screens with _pages variable at children
      // we need to attach our page controller here
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      drawer: Drawer(
          child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {
              //Initiate set state
              setState(() {
                // Show the position of the selected page index from the Array
                _selectedPageIndex = 0;

                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if (_pageController.hasClients) {
                    // Activate widget replacement/screen replacement
                    _pageController.animateToPage(0,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeInOut);
                  }
                });
                c.title.value = "Dashboard";
                Navigator.pop(context);
              });
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Help'),
            onTap: () {
              // Setting state and Activate widget replacement/screen replacement
              setState(() {
                _selectedPageIndex = 1;
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(1,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeInOut);
                  }
                });
                c.title.value = "Help";
                Navigator.pop(context);
              });
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              //Setting state by Activate widget replacement/screen replacement

              setState(() {
                _selectedPageIndex = 2;
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(2,
                        duration: Duration(milliseconds: 1),
                        curve: Curves.easeInOut);
                  }
                });
                c.title.value = "Settings";
                Navigator.pop(context);
              });
            },
          ),
        ],
      )),
    );
  }
}
