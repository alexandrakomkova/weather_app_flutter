import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:weather_app/presentation/cubit/ai_advice/advice_cubit.dart';

class ClothesRecommendationCard extends StatelessWidget {
  const ClothesRecommendationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 300,
      child: BlocBuilder<AdviceCubit, AdviceState>(
        builder: (_, state) {
          return switch (state.status) {
            AdviceStatus.initial => const SizedBox(),
            AdviceStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            AdviceStatus.failure => Text(state.errorMessage),
            AdviceStatus.success => Markdown(
              data: state.advice,
              styleSheet: MarkdownStyleSheet(
                p: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
          };
        },
      ),
    );
  }
}
