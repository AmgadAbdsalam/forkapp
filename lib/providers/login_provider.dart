import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive/domain/models/models.dart';
import 'package:responsive/presntation/login/view_model/login_view_model.dart';

final loginHelperProvider=Provider<AccessLoginProviders>((ref)=>AccessLoginProviders(ref));
class AccessLoginProviders{
  final Ref ref;
  AccessLoginProviders(this.ref);
  LoginViewModel  loginAccessMethod(){
    return ref.read(loginViewModelProvider.notifier);
  }
  LoginStateModel  loginWatchState(){
    return ref.watch(loginViewModelProvider);
  }
  LoginStateModel  loginReadState(){
    return ref.read(loginViewModelProvider);
  }
}