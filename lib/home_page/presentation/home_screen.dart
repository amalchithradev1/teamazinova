import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:demofirst/home_page/data/homescreen_items_provider.dart';
import 'package:demofirst/rest/hive_repo.dart';
import 'package:demofirst/routes/app_router.gr.dart';
import 'package:demofirst/theme/colors.dart';
import 'package:demofirst/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refreshData(WidgetRef ref) async {
    ref.refresh(homeScreenItemsListProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsState = ref.watch(homeScreenItemsListProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarColor,
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Text("Dashboard", style: themeData().primaryTextTheme.headlineMedium),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: (){
                _showLogoutConfirmationDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "Logout",
                  style: themeData().primaryTextTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
        ]
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshData(ref),
        child: itemsState.when(
          data: (itemsData) {
            final items = itemsData.result;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              padding: EdgeInsets.all(10),
              itemCount: items!.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  color: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {
                      context.pushRoute(DetailRoute(imageUrl: item.image.toString(), name:item.name.toString(), amount: item.amount.toString()));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.network(
                              item.image.toString(),
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.name.toString(),
                              style: themeData().primaryTextTheme.headlineSmall,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              item.amount.toString(),
                              style: themeData().primaryTextTheme.titleMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          loading: () {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              padding: EdgeInsets.all(10),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Column(
                      children: [
                        Expanded(
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              height: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                "Failed to load !",
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          },
        ),
      ),
    );
  }


  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Are you sure?",
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: Text(
            "Do you really want to log out?",
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performLogout(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _performLogout(BuildContext context) {
    HiveRepo.instance.logout();
    context.pushRoute(LoginRoute());
  }

}
