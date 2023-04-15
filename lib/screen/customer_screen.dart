import 'package:firebase_auth/firebase_auth.dart';
import 'package:utb_cafe/provider/my_provider.dart';
import 'package:utb_cafe/screen/vendor_1.dart';
import 'package:flutter/material.dart';
import 'package:utb_cafe/widgets/customized_drawer_custo.dart';
import 'package:utb_cafe/widgets/food_modle.dart';

import '../widgets/search.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen>
 with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Welcome"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
                );
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Vendor 1",
              icon: Icon(Icons.local_cafe_outlined),
            ),
            Tab(
              text: "Vendor 2",
              icon: Icon(Icons.local_cafe_outlined),
            ),
            Tab(
              text: "Vendor 3",
              icon: Icon(Icons.local_cafe_outlined),
            ),
          ],
        ),
      ),
      drawer: const CustomizedDrawerCusto(),

      body: TabBarView(
        controller: _tabController,
        children: const <Widget> [
          Vendor1(),
          Vendor1(),
          Vendor1(),
        ],
      ),
    );
  }
}



