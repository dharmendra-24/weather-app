import 'package:flutter/material.dart';

class ForcastItem extends StatelessWidget {
  final String time;
  final IconData icon;
  final String temprature;
  const ForcastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temprature,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 150,
      child: Card(
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Icon(
                icon,
                size: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '$temprature celcius',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
