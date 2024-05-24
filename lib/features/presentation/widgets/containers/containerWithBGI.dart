import 'package:flutter/material.dart';

class ContainerWithBGI extends StatefulWidget {
  const ContainerWithBGI({super.key});

  @override
  State<ContainerWithBGI> createState() => _ContainerWithBGIState();
}

class _ContainerWithBGIState extends State<ContainerWithBGI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/financeAppEmptyBg.jpg'), // Replace with your image path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6), // Change color and opacity as needed
            BlendMode.darken, // Change to other BlendMode values as needed
          ),
        ),
      ),
      child: const Center(child:
      Text(
        'No Transaction Found!',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      )
      ),
    );
  }
}
