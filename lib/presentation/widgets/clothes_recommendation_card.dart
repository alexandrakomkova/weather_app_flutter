import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:weather_app/presentation/cubit/ai_advice/advice_cubit.dart';

class ClothesRecommendationCard extends StatelessWidget {
  const ClothesRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: BlocBuilder<AdviceCubit, AdviceState>(
            builder: (adviceContext, adviceState) {
              return switch(adviceState.status) {
                AdviceStatus.initial => SizedBox(),
                AdviceStatus.loading => Center(child: CircularProgressIndicator(),),
                AdviceStatus.failure => Center(child: Text(adviceState.errorMessage)),
                AdviceStatus.success =>
                    Markdown(
                        data: adviceState.advice,
                        styleSheet: MarkdownStyleSheet(
                          p: const TextStyle(fontSize: 18, height: 1.4),
                        ))

              };
            },

      ),
    );
  }
}
