import 'package:flutter/material.dart';
import '../core/responsive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: rs(context, 24)),
          CircleAvatar(
              radius: rs(context, 40),
              child: Icon(Icons.person, size: rs(context, 48))),
          SizedBox(height: rs(context, 16)),
          Text('اسم المستخدم',
              style: TextStyle(
                  fontSize: rs(context, 18), fontWeight: FontWeight.bold)),
          SizedBox(height: rs(context, 8)),
          Text('user@example.com'),
        ],
      ),
    );
  }
}
