import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/ride_card.dart';
import '../providers/rides_provider.dart';
import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin
    final ridesProvider = Provider.of<RidesProvider>(context);
    final rides = ridesProvider.rides;
    final isLoading = ridesProvider.isLoading;
    final error = ridesProvider.error;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Available Rides'),
        backgroundColor: AppColors.primary,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ridesProvider.listenToRides();
            },
          ),
        ],
      ),
      body: error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 80, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    error,
                    style: const TextStyle(fontSize: 16, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      ridesProvider.clearError();
                      ridesProvider.listenToRides();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            )
          : rides.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_car,
                    size: 80,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No rides available',
                    style: TextStyle(fontSize: 18, color: AppColors.textLight),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Create a ride to get started!',
                    style: TextStyle(fontSize: 14, color: AppColors.textLight),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: rides.length,
              itemBuilder: (context, index) {
                return RepaintBoundary(
                  child: RideCard(
                    key: ValueKey(rides[index].id),
                    ride: rides[index],
                  ),
                );
              },
            ),
    );
  }
}
