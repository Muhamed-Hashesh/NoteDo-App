import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:notedo_app/json/datalist.dart';
import 'package:notedo_app/themes/colors.dart';
import 'package:notedo_app/widgets/calc_widgets/equal_button.dart';

class ButtonsContainer extends StatelessWidget {
  const ButtonsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.sizeOf(context).height;
    return Container(
      height: screenHight * 0.59,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        color: AppColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => buttonsList[index],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => buttonsList[index + 4],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              4,
              (index) => buttonsList[index + 8],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => buttonsList[index + 12],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        3,
                        (index) => buttonsList[index + 15],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              const EqualButton()
            ],
          )
        ],
      ),
    );
  }
}












// class ButtonsContainer extends StatelessWidget {
//   const ButtonsContainer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final screenHight = MediaQuery.sizeOf(context).height;
//     return Container(
//       height: screenHight * 0.6,
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
//         color: AppColors.primaryColor,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: List.generate(
//           buttonsList.length ~/ 4,
//           (index) {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: List.generate(
//                 4,
//                 (index) => buttonsList[4],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
