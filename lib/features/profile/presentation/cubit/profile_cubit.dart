import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:info_app/core/constants.dart';

import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';

import 'package:info_app/features/profile/domain/usecases/profile_usecase.dart';
import 'package:info_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:info_app/locator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileUsecase) : super(ProfileInitialState());

  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _cacheHelper = locator<CacheHelper>();
  final ProfileUsecase _profileUsecase;

  static ProfileCubit get(context) => BlocProvider.of(context);

  CodeModel? codeModel;

  Future<void> getCodeModel() async {
    var result = await _profileUsecase.getProfile();
    result.fold(
      (l) {
        print('fsdfdsf$l');
        emit(ProfileUpdateErrorState(error: l));
      },
      (r) {
        codeModel = r;
        emit(ProfileUpdateSuccessState());
      },
    );
    print('okkkkkkkkkkk${codeModel?.account?.toJson()}' ?? 'okkkkkkkkkkk');
    phoneController.text = codeModel?.account?.phone ?? '+7';
    emailController.text = codeModel?.account?.email ?? '';
  }

  Future<void> updateProfile() async {
    emit(ProfileUpdateLoadingState());
    final result = await _profileUsecase.updateProfile(
        codeModel?.account?.name ?? '',
        emailController.text,
        phoneController.text);
    result.fold(
      (l) {
        emit(ProfileUpdateErrorState(error: l));
      },
      (r) {
        phoneController.clear();
        emailController.clear();
        codeModel = r;
        codeModel!.token = token;
        _cacheHelper.saveUser(r);
        emit(ProfileUpdateSuccessState());
      },
    );
  }

  Future<void> pickImage() async {
    // emit(ProfileUpdateLoadingState());
    // try {
    //   Uint8List? bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
    //   try {
    //     String? imageName = await uploadImage(bytesFromPicker!);

    //     if (imageName != null) {
    //       print(imageName);
    //       getCodeModel();
    //       codeModel!.account!.avatar = imageName;
    //       emit(ProfileUpdateSuccessState());
    //     } else {
    //       emit(ProfileUpdateErrorState(error: "Image upload failed"));
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // } catch (e) {
    //   emit(ProfileUpdateErrorState(error: e.toString()));
    // }
  }

  Future<String?> uploadImage(Uint8List image) async {
    // print("image path $image");
    final headers = await _createHeaders();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$BASE_URL/account/avatar'),
    );

    request.files.add(
      http.MultipartFile.fromBytes(
        'avatar',
        image,
        filename: 'avatar.png',
      ),
    );
    request.headers.addAll(headers);
    final response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);
      codeModel = CodeModel.fromJson(jsonResponse);
      if (jsonResponse['result'] == true) {
        return jsonResponse['account']['avatar'];
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Map<String, String>> _createHeaders() async {
    return {
      'Authorization': token!,
      'Content-Type': 'multipart/form-data',
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers":
          "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
  }

  void signOut() async {
    await _cacheHelper.removeUser();
    await _cacheHelper.removeData(key: 'token');
  }
}
