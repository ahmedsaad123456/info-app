import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubscripeWidget extends StatelessWidget {


  const SubscripeWidget({super.key, required this.color, required this.text, required this.cost, required this.description, this.onTap, required this.selected, required this.textColor, this.width, this.height});
  final Color color;
  final String text;
  final String cost;
  final String description;
  final bool selected;
  final void Function()? onTap;
  final Color textColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withOpacity(0.08))
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  height: 18,
                  width: 18,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(72),
                    color: selected ? Colors.white : Colors.white.withOpacity(0.08),
                  ),
                ),
                const SizedBox(
                  width:26 ,
                ),
                Expanded(
                  child: Text("Подробнее", style: TextStyle(
                    color: Colors.white.withOpacity(0.48), fontSize: 14
                  ),),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(text, style: TextStyle(color: textColor, fontSize: 14),),
            const SizedBox(
              height: 4,
            ),
            Text(cost, style: const TextStyle(color: Colors.white, fontSize: 28, fontFeatures: <FontFeature>[
              FontFeature.slashedZero(),
            ],),),
            const SizedBox(
              height: 4,
            ),
            Text(description, style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.48), letterSpacing: -0.42),)
          ],
        ),
      ),
    );
  }
}
