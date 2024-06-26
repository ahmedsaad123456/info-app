import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:info_app/core/constants.dart';
import 'package:info_app/core/shared/datasources/local/cache_helper.dart';
import 'package:info_app/features/login_screen/data/models/code_model.dart';
import 'package:info_app/features/login_screen/data/models/user_model.dart';

import 'package:info_app/features/login_screen/domain/usecases/auth_usecase.dart';
import 'package:info_app/features/login_screen/presentation/cubit/auth_state.dart';
import 'package:info_app/locator.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authUseCase) : super(AuthInitialState());

  TextEditingController controller = TextEditingController();
  TextEditingController pinPutontroller = TextEditingController();

  final _cacheHelper = locator<CacheHelper>();
  final AuthUseCase _authUseCase;
  late UserModel userModel;

  static AuthCubit get(context) => BlocProvider.of(context);
  bool isDisabled = true;
  bool isPinputDisabled = true;

  Future<void> login() async {
    emit(AuthLoadingState());

    final result = await _authUseCase.login(controller.text, '');
    result.fold(
      (l) {
        emit(AuthErrorState(error: l));
      },
      (r) {
        controller.clear();
        userModel = r;
        emit(AuthSuccessState());
      },
    );
  }

  Future<void> confirmCode() async {
    emit(CodeLoadingState());
    final result = await _authUseCase.confirmCode(
        userModel.account_id ?? 0, int.parse(pinPutontroller.text));
    result.fold(
      (l) {
        emit(CodeErrorState(error: l));
      },
      (r) {
        controller.clear();
        _cacheHelper.saveUser(r);
        token = r.token;
        _cacheHelper.saveData(key: 'token', value: token);
        emit(CodeSuccessState());
      },
    );
  }

  void changeForm(String v) {
    if (v.isEmpty) {
      isDisabled = true;
    } else {
      isDisabled = false;
    }

    emit(ChangeFormState());
  }

  void changePinput(String v) {
    pinPutontroller.text = v;
    if (v.length == 4) {
      isPinputDisabled = false;
    } else {
      isPinputDisabled = true;
    }

    emit(ChangeFormState());
  }
}
