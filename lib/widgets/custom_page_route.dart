import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class CustomPageRoute extends PageRouteBuilder{
  final Widget child;

  CustomPageRoute({required this.child}):super(
    transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation)=>child
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child){
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}