import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:dribbble_challenge/src/core/theme/app_colors.dart';

// ignore: must_be_immutable
class TimeLineWidget extends StatefulWidget {
  final List<String> steps;
  List<bool> isCheckedList;

  TimeLineWidget({
    super.key,
    required this.steps,
    required this.isCheckedList,
  });

  @override
  State<TimeLineWidget> createState() => _TimeLineWidgetState();
}

class _TimeLineWidgetState extends State<TimeLineWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.steps.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              widget.isCheckedList[index] =
                  !widget.isCheckedList[index];
            });
          },
          child: CustomTimeLineTile(
            index: index,
            steps: widget.steps,
            isCheckedList: widget.isCheckedList,
          ),
        );
      },
    )
        .animate(delay: 2400.ms)
        .fadeIn(delay: 500.ms)
        .slideY(begin: 0.2, end: 0);
  }
}

class CustomTimeLineTile extends StatelessWidget {
  final List<bool> isCheckedList;
  final int index;
  final List<String> steps;

  const CustomTimeLineTile({
    super.key,
    required this.isCheckedList,
    required this.index,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final isChecked = isCheckedList[index];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// LEFT SIDE (LINE + DOT)
          Column(
            children: [
              // Top line
              if (index != 0)
                Container(
                  width: 2,
                  height: 20,
                  color: isChecked
                      ? AppColors.timeLineColor
                      : AppColors.timeLineColor.withOpacity(0.3),
                ),

              // Dot
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isChecked
                      ? AppColors.timeLineColor
                      : Colors.transparent,
                  border: Border.all(
                    color: AppColors.timeLineColor,
                    width: 2,
                  ),
                ),
                child: isChecked
                    ? const Icon(Icons.check, size: 15, color: Colors.black)
                    : null,
              ),

              // Bottom line
              if (index != steps.length - 1)
                Container(
                  width: 2,
                  height: 40,
                  color: isChecked
                      ? AppColors.timeLineColor
                      : AppColors.timeLineColor.withOpacity(0.3),
                ),
            ],
          ),

          const SizedBox(width: 12),

          /// RIGHT SIDE (TEXT)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Step ${index + 1}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    steps[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              )
                  .animate(delay: 2800.ms)
                  .fadeIn(delay: (350 * index).ms)
                  .slideY(begin: 0.3, end: 0),
            ),
          ),
        ],
      ),
    );
  }
}