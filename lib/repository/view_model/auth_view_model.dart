import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../auth_repository.dart';

class AuthViewModel with ChangeNotifier{
  final _myRepo = AuthRepository();
  Future<void> fetchListApi(BuildContext context) async{
    _myRepo.fetchListApi().then((value){


    }).onError((error,stackTrace){
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}