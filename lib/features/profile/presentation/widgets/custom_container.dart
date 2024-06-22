import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  final Widget icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.12),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: ListTile(
          leading:icon,
          title: Text(
            title,
            style: TextStyle(color: Colors.white.withOpacity(0.84)),
          ),
          trailing: Icon(Icons.arrow_forward_ios,
              color: Colors.white.withOpacity(0.48)),
        ),
      ),
    );
  }
}
