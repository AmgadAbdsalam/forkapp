import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/app/di.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/base/base_view_model.dart';
import 'package:responsive/presntation/common/state_render/state_render_impl.dart';

import '../../../domain/use_cases/login_usecase.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_render/state_render.dart';


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
  getContentState(){
    state=state.copyWith(flowState: ContentState());
  }

}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

}

final loginViewModelProvider=StateNotifierProvider<LoginViewModel,LoginStateModel>((ref)=>LoginViewModel(instance<LoginUseCase>(),ref));




/*import 'dart:async';

import 'package:responsive/presntation/base/base_view_model.dart';

import '../../../domain/use_cases/login_usecase.dart';
import '../../common/freezed_data_classes.dart';


class LoginViewModel extends BaseViewModel
    implements LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
  StreamController<String>.broadcast();
  final StreamController _passwordStreamController =

  StreamController<String>.broadcast();  // inputs
  final StreamController _areAllInputsValidStreamController =
  StreamController<void>.broadcast();

  var loginObject = LoginObject("","");

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);
  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;


  @override
  setPassword(String password) {
   inputPassword.add(password);
   loginObject=loginObject.copyWith(password: password);
   inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
   inputUserName.add(userName);
   loginObject=loginObject.copyWith(useName: userName);
   inputAreAllInputsValid.add(null);
  }

  @override
  login() async {
    (await _loginUseCase.execute(
        LoginUseCaseInput(loginObject.useName, loginObject.password)))
        .fold((failure) =>
    {
      // left -> failure
      print(failure.message)
    }, (data) =>
    {
      // right -> data (success)
      print(data.customer?.name)
    });
  }

  // outputs
  @override
  Stream<bool> get outIsPasswordValid =>_passwordStreamController.stream.map((password)=>_isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream.map((userName)=>_isUserNameValid(userName));
  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());


  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }


  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.useName);
  }
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  Sink get inputUserName;

  Sink get inputPassword;
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;
  Stream<bool> get outAreAllInputsValid;

}*/