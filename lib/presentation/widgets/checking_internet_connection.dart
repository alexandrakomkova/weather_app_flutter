import 'package:flutter/material.dart';

class CheckingInternetConnection extends StatelessWidget {
  const CheckingInternetConnection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
          ),
          SizedBox(height: 8.0,),
          Text(
            'Checking your Internet connection..',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: theme.colorScheme.primary
            ),
          ),
        ],
      ),
    );
  }
}
