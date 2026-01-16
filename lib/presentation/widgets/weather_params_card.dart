import 'package:flutter/material.dart';

class WeatherParamsCard extends StatelessWidget {
  final String cardIcon;
  final String cardTitle;
  final String value;

  const WeatherParamsCard({
    required this.cardIcon,
    required this.cardTitle,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Image.asset(cardIcon, scale: 13.0, color: theme.colorScheme.primary),
        const SizedBox(width: 12.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cardTitle,
              style: theme.textTheme.bodySmall!.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 3.0),
            Text(
              value,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
