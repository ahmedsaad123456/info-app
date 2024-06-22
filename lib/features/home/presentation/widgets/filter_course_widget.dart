import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/features/courses/widgets/title_widget.dart';
import 'package:info_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:info_app/widget/custom_button.dart';

class FilterCourseWidget extends StatelessWidget {
  const FilterCourseWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
  });

  final String title, subtitle;
  final int type;

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    List<String> categories;

    if (type == 1) {
      categories = homeCubit.demoCategories;
    } else if (type == 2) {
      categories = homeCubit.neroCategories;
    } else {
      categories = homeCubit.neroPlusCategories;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: title, subtitle: subtitle),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: categories
              .map((category) => IntrinsicWidth(
                      child: ToggleButtonWidget(
                    text: category,
                    type: type,
                    isOneButton: categories.length == 1 ? true : false,
                  )))
              .toList(),
        ),
      ],
    );
  }
}

class ToggleButtonWidget extends StatefulWidget {
  final String text;
  final int type;
  final bool isOneButton;

  const ToggleButtonWidget(
      {super.key,
      required this.text,
      required this.type,
      required this.isOneButton});

  @override
  _ToggleButtonWidgetState createState() => _ToggleButtonWidgetState();
}

class _ToggleButtonWidgetState extends State<ToggleButtonWidget> {
  bool isSelected = false;

  void toggleButton() {
    setState(() {
      isSelected = !isSelected;
      BlocProvider.of<HomeCubit>(context)
          .toggleCategory(widget.text, widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isOneButton ? () {} : toggleButton,
      child: ButtonWidget(
        padding: 10,
        text: widget.text,
        height: 43,
        color: isSelected || widget.isOneButton ? Colors.white : Colors.white.withOpacity(0.08),
        textColor: isSelected || widget.isOneButton ? Colors.black : Colors.white.withOpacity(0.64),
        boxBorder: !isSelected
            ? Border.all(width: 2, color: Colors.white.withOpacity(0.08))
            : null,
      ),
    );
  }
}
