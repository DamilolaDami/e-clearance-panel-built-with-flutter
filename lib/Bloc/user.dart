import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schoolmanagement/Bloc/blocstate.dart';
import 'package:schoolmanagement/Bloc/userbloc.dart';
import 'package:schoolmanagement/repository/userrepo.dart';

class UserBloc extends Cubit<BlocState> {
  UserBloc() : super(Initial());

  User? _user;
  void authenticate(String mobile, String password) async {
    if (state is Loading) return;
    emit(Loading());
    try {
     _user = await UserRepo.authenticate(mobile, password);
      
    } catch (e) {
      emit(Failed(e as Exception));
    }
  }

  User? get user => _user;
}
