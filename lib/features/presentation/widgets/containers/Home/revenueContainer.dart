import 'package:flutter/material.dart';
import 'package:finance/config/theme/colors/color_code.dart';

class revenueContainer extends StatefulWidget {
  final Map<String, dynamic> financialData;
  const revenueContainer({
    super.key,
    required this.financialData,
  });

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
        image: DecorationImage(
          image: AssetImage('assets/images/financeRevenueCardBG.webp'), // Replace with your image path
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5), // Change color and opacity as needed
            BlendMode.darken, // Change to other BlendMode values as needed
          ),
        ),
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
                      Text("Year-${widget.financialData!['year']?? ''}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white
                        ),
                      ),
                      const Text("Total Revenue",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 27,
                          color: Colors.white
                        ),
                      ),
                      Text("₹${(widget.financialData!['debit']+widget.financialData!['credit'])?? ''}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: lightGreen,
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
                                const Text("Total Debit",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white
                                  ),
                                ),
                                Text("₹${widget.financialData!['debit']?? ''}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: lightGreen,
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
                              const Text("Total Credit",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white
                                ),
                              ),
                              Text("₹${widget.financialData!['credit'].abs()?? ''}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: lightRed,
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
