
import 'package:chat_call_feature/core/enums/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class BaseViewModal extends ChangeNotifier{
  ViewState _state=ViewState.idle;
  ViewState get state => _state;

  void setState(ViewState state){
    _state = state;
    notifyListeners();
  }
}