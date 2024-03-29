import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

abstract class BlocBase {
  void dispose();
}

class UpdateHeaderItem {
  UpdateHeaderItem({
    this.itemId = 0,
    this.value = false,
  });
  int itemId;
  bool value;
}

class FavoriteBloc implements BlocBase {
  BehaviorSubject<UpdateHeaderItem> _headerUpdateController =
      BehaviorSubject<UpdateHeaderItem>();
  Sink<UpdateHeaderItem> get inUpdateHeader => _headerUpdateController.sink;
  Stream<UpdateHeaderItem> get outUpdateHeader =>
      _headerUpdateController.stream;

  BehaviorSubject<UpdateHeaderItem> _bodyUpdateController =
      BehaviorSubject<UpdateHeaderItem>();
  Sink<UpdateHeaderItem> get inUpdateBody => _bodyUpdateController.sink;
  Stream<UpdateHeaderItem> get outUpdateBody => _bodyUpdateController.stream;

  FavoriteBloc() {}

  void dispose() {
    _headerUpdateController.close();
    _bodyUpdateController.close();
  }

  void updateHeader(bool shouldSelectHeader, int itemId) {
    inUpdateHeader
        .add(UpdateHeaderItem(value: shouldSelectHeader, itemId: itemId));
  }

  void updateBody(bool shouldSelectAllBody, int itemId) {
    inUpdateBody
        .add(UpdateHeaderItem(value: shouldSelectAllBody, itemId: itemId));
  }
}

// ------------------------------------------------ INHERITTED WIDGET => IGNORE HERE ------------------------------------------------ //
Type _typeOf<T>() => T;

class BlocProvider<T extends BlocBase> extends StatefulWidget {
  BlocProvider({
    Key key,
    @required this.child,
    @required this.bloc,
  }) : super(key: key);

  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() => _BlocProviderState<T>();

  static T of<T extends BlocBase>(BuildContext context) {
    final type = _typeOf<_BlocProviderInherited<T>>();
    _BlocProviderInherited<T> provider =
        context.ancestorInheritedElementForWidgetOfExactType(type)?.widget;
    return provider?.bloc;
  }
}

class _BlocProviderState<T extends BlocBase> extends State<BlocProvider<T>> {
  @override
  void dispose() {
    widget.bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new _BlocProviderInherited<T>(
      bloc: widget.bloc,
      child: widget.child,
    );
  }
}

class _BlocProviderInherited<T> extends InheritedWidget {
  _BlocProviderInherited({
    Key key,
    @required Widget child,
    @required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) => false;
}
