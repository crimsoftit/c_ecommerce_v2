import 'package:flutter/material.dart';

class CProductPriceText extends StatelessWidget {
  const CProductPriceText({
    super.key,
    this.currencySymbol = 'ksh. ',
    required this.price,
    this.maxLines = 1,
    this.isLarge = false,
    this.lineThrough = false,
  });

  final String currencySymbol, price;
  final int maxLines;
  final bool isLarge, lineThrough;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySymbol + price,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: isLarge
          ? Theme.of(context).textTheme.labelMedium!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
                fontSizeFactor: 1.0,
                fontWeightDelta: 2,
              )
          : Theme.of(context).textTheme.labelMedium!.apply(
                decoration: lineThrough ? TextDecoration.lineThrough : null,
                fontSizeFactor: 0.9,
                fontWeightDelta: 2,
              ),
    );
  }
}
