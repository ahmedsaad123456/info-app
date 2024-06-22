import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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
    codeModel ??= await _cacheHelper.getUser();
    print(codeModel?.account?.toJson() ?? 'okkkkkkkkkkk');
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
    emit(ProfileUpdateLoadingState());
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );

      if (result != null && result.files.first.path != null) {
        File imageFile = File(result.files.first.path!);
        String? imageName = await uploadImage(imageFile);

        if (imageName != null) {
          String imageUrl = BASE_URL + imageName;
          codeModel!.account!.avatar = imageUrl;

          // await _cacheHelper.saveUser(codeModel!);
          emit(ProfileUpdateSuccessState());
        } else {
          emit(ProfileUpdateErrorState(error: "Image upload failed"));
        }
      } else {
        emit(ProfileUpdateErrorState(
            error: "No image selected or invalid image data"));
      }
    } catch (e) {
      emit(ProfileUpdateErrorState(error: e.toString()));
    }
  }

  Future<String?> uploadImage(File image) async {
    final headers = await _createHeaders();
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${BASE_URL}/account/avatar'),
    );


    request.files.add(
      await http.MultipartFile.fromPath(
        'file',
        image.path,
      ),
    );
    request.headers.addAll(headers);

    final response = await request.send();
    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      final jsonResponse = jsonDecode(responseBody);
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
      'Content-Type': "application/json",
    };
  }

  void signOut() async {
    await _cacheHelper.removeUser();
    await _cacheHelper.removeData(key: 'token');
  }
}
