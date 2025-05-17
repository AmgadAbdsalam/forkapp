

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/base/base_view_model.dart';

import '../../../domain/use_cases/login_usecase.dart';
import '../../common/freezed_data_classes.dart';


class LoginViewModel extends StateNotifier<LoginStateModel> implements BaseViewModel, LoginViewModelInputs {

//StreamController userLogin=StreamController<bool>();
  final Ref ref;
  var loginObject = LoginObject("","");
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase, this.ref) : super(LoginStateModel(true, true, false,false));

  @override
  void start() {
    ref.read(flowStateMangerProvider.notifier).setContent();
  }


  @override
  setPassword(String password) {
   loginObject=loginObject.copyWith(password: password);
   _isPasswordValid(password);
  _areAllInputsValid();
  }

  @override
  setUserName(String userName) {
   loginObject=loginObject.copyWith(useName: userName);
   _isUserNameValid(userName);
   _areAllInputsValid();

  }

  @override
  login() async {
    print('loding state');
    ref.read(flowStateMangerProvider.notifier).setLoading();
    (await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.useName, loginObject.password)))
        .fold((failure) =>
    {
      // left -> failure
    ref.read(flowStateMangerProvider.notifier).setError(failure.message)

    }, (data)
    {
      // right -> data (success)

      ref.read(flowStateMangerProvider.notifier).setContent();
      state= state.copyWith(isUserSuccessfulLogin: true,);
      print(state.isUserSuccessfulLogin);

    // userLogin.add(true);


    });
  }

  
 bool  _isPasswordValid(String password) {
    state= state.copyWith(isPasswordValid: password.isNotEmpty);
    return password.isNotEmpty;
  }

 bool  _isUserNameValid(String userName) {
    state=state.copyWith(isUsernameValid: userName.isNotEmpty);
    return userName.isNotEmpty;
  }


  bool _areAllInputsValid() {
   bool result= _isPasswordValid(loginObject.password) &&
       _isUserNameValid(loginObject.useName);
     state=state.copyWith(isPasswordAndUserNameValid:result );
    return result;
  }

}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

}

final loginViewModelProvider=StateNotifierProvider<LoginViewModel,LoginStateModel>((ref)=>LoginViewModel(instance<LoginUseCase>(),ref));



