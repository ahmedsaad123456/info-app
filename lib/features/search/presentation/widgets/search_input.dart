import 'package:flutter/material.dart';
import 'package:info_app/features/search/presentation/cubit/search_cubit.dart';
import 'package:info_app/widget/custom_textfiled.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      iconData: Icon(
        Icons.search,
        color: Colors.white.withOpacity(0.12),
      ),
      keyboardType: TextInputType.emailAddress,
      onChanged: (val) {
        print("cccc$val");
        SearchCubit.get(context).search(context, val);
      },
      validator: (v) {
        if (v!.isEmpty) {
          return "error";
        }
        return null;
      },
      textHint: 'Поиск',
    );
  }
}
