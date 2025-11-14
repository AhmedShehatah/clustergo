import 'package:flutter/material.dart';
import '../widgets/ride_card.dart';
import '../utils/sample_data.dart';
import '../utils/colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rides = getSampleRides();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Available Rides'),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: rides.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.directions_car, size: 80, color: AppColors.textLight),
                  SizedBox(height: 16),
                  Text(
                    'No rides available',
                    style: TextStyle(fontSize: 18, color: AppColors.textLight),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: rides.length,
              itemBuilder: (context, index) {
                return RideCard(ride: rides[index]);
              },
            ),
    );
  }
}