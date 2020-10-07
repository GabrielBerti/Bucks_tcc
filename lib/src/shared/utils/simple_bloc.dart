import 'package:bucks/src/shared/utils/progress_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_pattern/bloc_pattern.dart';

import 'fingerprint_bloc.dart';

class SimpleBloc<T> extends BlocBase {
  final progress = ProgressBloc();
  final fingerprint = FingerPrintBloc();

  // stream
  final _controller = BehaviorSubject<T>();
  get stream => _controller.stream;

  get add => _controller.sink.add;

  get addError => _controller.sink.addError;

  @override
  void dispose() {
    super.dispose();

    _controller.close();

    progress.close();
  }
}
