import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class LoadingIndicator<T> extends StatelessWidget {

  final FutureStatus status;

  const LoadingIndicator({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) => Observer(
      builder: (_) => status == FutureStatus.pending
          ? const LinearProgressIndicator()
          : Container());
}
