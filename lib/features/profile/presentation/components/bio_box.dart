import 'package:flutter/material.dart';

class BioBox extends StatelessWidget {
  final String text;
  const BioBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return  Container(
      // padding inside the box
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      child: Text(text.isNotEmpty ? text : 'Empy bio.....', style: TextStyle(color:Theme.of(context).colorScheme.inversePrimary,),)
    );
  }
}
