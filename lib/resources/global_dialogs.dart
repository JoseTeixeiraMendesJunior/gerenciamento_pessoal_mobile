import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

/// PARA PEGAR RETORNO USE O NAVIGATOR.POP() COM true OR false;

Future<dynamic> animatedDialogPadrao(BuildContext context, build,
    {dismiss = true}) async {
  return await showAnimatedDialog(
      context: context,
      barrierDismissible: dismiss,
      animationType: DialogTransitionType.scale,
      curve: Curves.easeInBack,
      duration: const Duration(seconds: 1),
      builder: (_) => build);
}

Future<dynamic> animatedDialogPersistent(BuildContext context, build) async {
  return await showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      animationType: DialogTransitionType.scale,
      curve: Curves.easeInBack,
      duration: const Duration(seconds: 1),
      builder: (_) => build);
}

Future<dynamic> animatedGeneralDialog(BuildContext context, build) async {
  return await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white24,
      transitionDuration: const Duration(seconds: 1),
      pageBuilder: (BuildContext context, Animation first, Animation second) {
        return build;
      });
}