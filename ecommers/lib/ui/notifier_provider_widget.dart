import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotifierProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final Widget Function(BuildContext context, T model, Widget child) builder;
  final T providerModel;
  final Widget child;
  final Function(T) onModelReady;

  const NotifierProviderWidget({
    Key key,
    this.builder,
    this.child,
    this.providerModel,
    this.onModelReady,
  }) : super(key: key);

  @override
  _NotifierProviderWidgetState<T> createState() => _NotifierProviderWidgetState<T>();
}

class _NotifierProviderWidgetState<T extends ChangeNotifier> extends State<NotifierProviderWidget<T>> {
  T providerModel;

  @override
  void initState() {
    providerModel = widget.providerModel;
    
    if (widget.onModelReady != null) {
      widget.onModelReady(providerModel);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (context) => providerModel,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.child,
      ),
    );
  }
}