import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:weather_app/presentation/cubit/ai_advice/advice_cubit.dart';

class ClothesRecommendationCard extends StatelessWidget {
  const ClothesRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Expanded(
        child: BlocBuilder<AdviceCubit, AdviceState>(
          builder: (adviceContext, adviceState) {
            return switch(adviceState.status) {
              AdviceStatus.initial => SizedBox(),
              AdviceStatus.loading => Center(child: CircularProgressIndicator(),),
              AdviceStatus.failure => Text(adviceState.errorMessage),
              AdviceStatus.success => Markdown(
                  data: adviceState.advice,
              ),
            };
          },
        ),
    );
  }
}
