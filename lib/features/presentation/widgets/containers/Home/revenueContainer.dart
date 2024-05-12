import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';

class revenueContainer extends StatefulWidget {
  const revenueContainer({super.key});

  @override
  State<revenueContainer> createState() => _revenueContainerState();
}

class _revenueContainerState extends State<revenueContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 16,
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: const [
          // BoxShadow(
          //   spreadRadius: 3,
          //   blurRadius: 3,
          //   offset: Offset(0, 0),
          //   color: boxShadow,
          // ),
        ],
      ),

      child: Column(
        children: [
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Text("Year- 2024",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: bluePrimary
                        ),
                      ),
                      Text("Total Revenue",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 27,
                        ),
                      ),
                      Text("₹1,504,564",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.green
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),

          Expanded(
            flex: 3,
              child: Container(
                child: Row(
                  children: [

                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text("Total Debit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                  ),
                                ),
                                Text("₹9,584,161",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.green
                                  ),
                                ),
                              ],
                          ),
                        )
                    ),

                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Total Credit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text("₹8,079,597",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.red
                                ),
                              ),
                            ],
                          ),
                        )
                    )

                  ],
                ),
              )
          )
        ],
      )
    );
  }
}
