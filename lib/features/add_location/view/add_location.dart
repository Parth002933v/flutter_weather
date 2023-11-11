import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_weather/common/utils/constants.dart';
import 'package:flutter_weather/features/add_location/widgets/widgets.dart';

class SavedLocation extends ConsumerWidget {
  const SavedLocation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.shade800,
        image: const DecorationImage(
          image: AssetImage(ImageConstants.BG1),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Scaffold(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  appBar(),
                  SizedBox(height: 5.h),
                  savedLocationList(),
                  SizedBox(height: 10.h),
                  addNewLocationCard()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
