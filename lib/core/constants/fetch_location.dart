import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g3_interactive_task/shared/common_widgets/custom_snackbar.dart';
import 'package:geolocator/geolocator.dart';

Future fetchLocationDetails(BuildContext context) async {
  try {
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!context.mounted) return;
    // if (!serviceEnabled) {
    //   showDialog(
    //     context: context,
    //     builder: (_) => AlertDialog(
    //       title: const Text("Location Disabled"),
    //       content: const Text("Please enable location services in settings."),
    //       actions: [
    //         TextButton(
    //           onPressed: () => Navigator.of(context).pop(),
    //           child: const Text("Cancel"),
    //         ),
    //         TextButton(
    //           onPressed: () {
    //             Geolocator.openLocationSettings();
    //             Navigator.of(context).pop();
    //           },
    //           child: const Text("Open Settings"),
    //         ),
    //       ],
    //     ),
    //   );
    //   return;
    // }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Location permissions are denied")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Permission Required"),
          content: const Text(
              "Location permissions are permanently denied. Please enable them in app settings."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Geolocator.openAppSettings();
                Navigator.of(context).pop();
              },
              child: const Text("Open Settings"),
            ),
          ],
        ),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.bestForNavigation,
    );

    return position;
  } catch (e) {
    log('Error: $e');
    if (!context.mounted) return;

    customSnackbar(context, "location fetch failed!");
  } finally {}
}
