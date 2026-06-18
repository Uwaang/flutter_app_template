import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_app_template/core/widgets/app_error_state.dart';
import 'package:flutter_app_template/core/widgets/app_loading_state.dart';

class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    this.loadingMessage,
    this.errorTitle = 'Something went wrong',
    this.errorMessage,
    this.onRetry,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T value) data;
  final String? loadingMessage;
  final String errorTitle;
  final String Function(Object error)? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (error, stackTrace) => AppErrorState(
        title: errorTitle,
        message: errorMessage?.call(error),
        onRetry: onRetry,
      ),
      loading: () => AppLoadingState(message: loadingMessage),
    );
  }
}
