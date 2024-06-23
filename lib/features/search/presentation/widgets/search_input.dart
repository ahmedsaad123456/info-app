import 'package:flutter/material.dart';
import 'package:info_app/features/search/presentation/cubit/search_cubit.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: SearchCubit.get(context).controller,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: InputDecoration(
        hintText: 'Поиск',
        hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.12),
            fontWeight: FontWeight.w400),
        filled: true,
        fillColor: Colors.white.withOpacity(0.12),
        border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: Colors.white.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(12.0),
        ),
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white.withOpacity(0.12),
        ),
      ),
    );
  }
}
