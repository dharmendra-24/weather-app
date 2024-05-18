import 'package:flutter/material.dart';

class AdditionalinformationItem extends StatelessWidget {
  final IconData icon;
  final String lable;
  final String value;
  const AdditionalinformationItem({
    super.key,
    required this.icon,
    required this.lable,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:20,vertical: 5),
      child: Column(
        children: [
          Icon(icon,size:25),
          const SizedBox(height:10,),
          Text(lable),
          const SizedBox(height:10,),
          Text(value,style:const TextStyle(fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}