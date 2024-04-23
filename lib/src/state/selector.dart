// ignore_for_file: library_private_types_in_public_api, use_to_and_as_if_applicable

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:responsive_frame/responsive_frame.dart';

typedef ShouldRebuild<T> = bool Function(T previous, T next);

class Selector0<T> extends SingleChildStatefulWidget {
  /// Both `builder` and `selector` must not be `null`.
  const Selector0({
    required this.builder,
    required this.selector,
    super.key,
    ShouldRebuild<T>? shouldRebuild,
    super.child,
  }) : _shouldRebuild = shouldRebuild;

  /// A function that builds a widget tree from `child` and the last result of
  /// [selector].
  ///
  /// [builder] will be called again whenever the its parent widget asks for an
  /// update, or if [selector] return a value that is different from the
  /// previous one using [operator==].
  ///
  /// Must not be `null`.
  final ValueWidgetBuilder<T> builder;

  /// A function that obtains some [InheritedWidget] and map their content into
  /// a new object with only a limited number of properties.
  ///
  /// The returned object must implement [operator==].
  ///
  /// Must not be `null`
  final T Function(BuildContext) selector;

  final ShouldRebuild<T>? _shouldRebuild;

  @override
  _Selector0State<T> createState() => _Selector0State<T>();
}

class _Selector0State<T> extends SingleChildState<Selector0<T>> {
  T? value;
  Widget? cache;
  Widget? oldWidget;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    final selected = widget.selector(context);

    final shouldInvalidateCache = oldWidget != widget ||
        (widget._shouldRebuild != null &&
            widget._shouldRebuild!(value as T, selected)) ||
        (widget._shouldRebuild == null &&
            !const DeepCollectionEquality().equals(value, selected));
    if (shouldInvalidateCache) {
      value = selected;
      oldWidget = widget;
      cache = Builder(
        builder: (context) => widget.builder(
          context,
          selected,
          child,
        ),
      );
    }
    return cache!;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<T>('value', value));
  }
}

class Selector<A, S> extends Selector0<S> {
  Selector({
    required super.builder,
    required S Function(BuildContext, A) selector,
    super.key,
    super.shouldRebuild,
    super.child,
  }) : super(
          selector: (context) =>
              selector(context, ResponsiveData.of(context) as A),
        );
}

/// A widget that simplify the writing of deeply nested widget trees.
///
/// It relies on the new kind of widget [SingleChildWidget], which has two
/// concrete implementations:
/// - [SingleChildStatelessWidget]
/// - [SingleChildStatefulWidget]
///
/// They are both respectively a [SingleChildWidget] variant of [StatelessWidget]
/// and [StatefulWidget].
///
/// The difference between a widget and its single-child variant is that they have
/// a custom `build` method that takes an extra parameter.
///
/// As such, a `StatelessWidget` would be:
///
/// ```dart
/// class MyWidget extends StatelessWidget {
///   MyWidget({Key key, this.child}): super(key: key);
///
///   final Widget child;
///
///   @override
///   Widget build(BuildContext context) {
///     return SomethingWidget(child: child);
///   }
/// }
/// ```
///
/// Whereas a [SingleChildStatelessWidget] would be:
///
/// ```dart
/// class MyWidget extends SingleChildStatelessWidget {
///   MyWidget({Key key, Widget child}): super(key: key, child: child);
///
///   @override
///   Widget buildWithChild(BuildContext context, Widget child) {
///     return SomethingWidget(child: child);
///   }
/// }
/// ```
///
/// This allows our new `MyWidget` to be used both with:
///
/// ```dart
/// MyWidget(
///   child: AnotherWidget(),
/// )
/// ```
///
/// and to be placed inside `children` of [Nested] like so:
///
/// ```dart
/// Nested(
///   children: [
///     MyWidget(),
///     ...
///   ],
///   child: AnotherWidget(),
/// )
/// ```
class Nested extends StatelessWidget implements SingleChildWidget {
  /// Allows configuring key, children and child
  Nested({
    required List<SingleChildWidget> children,
    super.key,
    Widget? child,
  })  : assert(children.isNotEmpty, ''),
        _children = children,
        _child = child;

  final List<SingleChildWidget> _children;
  final Widget? _child;

  @override
  Widget build(BuildContext context) {
    throw StateError('implemented internally');
  }

  @override
  _NestedElement createElement() => _NestedElement(this);
}

class _NestedElement extends StatelessElement
    with SingleChildWidgetElementMixin {
  _NestedElement(Nested super.widget);

  @override
  Nested get widget => super.widget as Nested;

  final nodes = <_NestedHookElement>{};

  @override
  Widget build() {
    _NestedHook? nestedHook;
    var nextNode = _parent?.injectedChild ?? widget._child;

    for (final child in widget._children.reversed) {
      nextNode = nestedHook = _NestedHook(
        owner: this,
        wrappedWidget: child,
        injectedChild: nextNode,
      );
    }

    if (nestedHook != null) {
      // We manually update _NestedHookElement instead of letter widgets do their thing
      // because an item N may be constant but N+1 not. So, if we used widgets
      // then N+1 wouldn't rebuild because N didn't change
      for (final node in nodes) {
        node
          ..wrappedChild = nestedHook!.wrappedWidget
          ..injectedChild = nestedHook.injectedChild;

        final next = nestedHook.injectedChild;
        if (next is _NestedHook) {
          nestedHook = next;
        } else {
          break;
        }
      }
    }

    return nextNode!;
  }
}

class _NestedHook extends StatelessWidget {
  const _NestedHook({
    required this.wrappedWidget,
    required this.owner,
    this.injectedChild,
  });

  final SingleChildWidget wrappedWidget;
  final Widget? injectedChild;
  final _NestedElement owner;

  @override
  _NestedHookElement createElement() => _NestedHookElement(this);

  @override
  Widget build(BuildContext context) => throw StateError('handled internally');
}

class _NestedHookElement extends StatelessElement {
  _NestedHookElement(_NestedHook super.widget);

  @override
  _NestedHook get widget => super.widget as _NestedHook;

  Widget? _injectedChild;
  Widget? get injectedChild => _injectedChild;
  set injectedChild(Widget? value) {
    final previous = _injectedChild;
    if (value is _NestedHook &&
        previous is _NestedHook &&
        Widget.canUpdate(value.wrappedWidget, previous.wrappedWidget)) {
      // no need to rebuild the wrapped widget just for a _NestedHook.
      // The widget doesn't matter here, only its Element.
      return;
    }
    if (previous != value) {
      _injectedChild = value;
      visitChildren((e) => e.markNeedsBuild());
    }
  }

  SingleChildWidget? _wrappedChild;
  SingleChildWidget? get wrappedChild => _wrappedChild;
  set wrappedChild(SingleChildWidget? value) {
    if (_wrappedChild != value) {
      _wrappedChild = value;
      markNeedsBuild();
    }
  }

  @override
  void mount(Element? parent, dynamic newSlot) {
    widget.owner.nodes.add(this);
    _wrappedChild = widget.wrappedWidget;
    _injectedChild = widget.injectedChild;
    super.mount(parent, newSlot);
  }

  @override
  void unmount() {
    widget.owner.nodes.remove(this);
    super.unmount();
  }

  @override
  Widget build() {
    return wrappedChild!;
  }
}

/// A [Widget] that takes a single descendant.
///
/// As opposed to [ProxyWidget], it may have a "build" method.
///
/// See also:
/// - [SingleChildStatelessWidget]
/// - [SingleChildStatefulWidget]
abstract class SingleChildWidget implements Widget {
  @override
  SingleChildWidgetElementMixin createElement();
}

mixin SingleChildWidgetElementMixin on Element {
  _NestedHookElement? _parent;

  @override
  void mount(Element? parent, dynamic newSlot) {
    if (parent is _NestedHookElement?) {
      _parent = parent;
    }
    super.mount(parent, newSlot);
  }

  @override
  void activate() {
    super.activate();
    visitAncestorElements((parent) {
      if (parent is _NestedHookElement) {
        _parent = parent;
      }
      return false;
    });
  }
}

/// A [StatelessWidget] that implements [SingleChildWidget] and is therefore
/// compatible with [Nested].
///
/// Its [build] method must **not** be overriden. Instead use [buildWithChild].
abstract class SingleChildStatelessWidget extends StatelessWidget
    implements SingleChildWidget {
  /// Creates a widget that has exactly one child widget.
  const SingleChildStatelessWidget({super.key, Widget? child}) : _child = child;

  final Widget? _child;

  /// A [build] method that receives an extra `child` parameter.
  ///
  /// This method may be called with a `child` different from the parameter
  /// passed to the constructor of [SingleChildStatelessWidget].
  /// It may also be called again with a different `child`, without this widget
  /// being recreated.
  Widget buildWithChild(BuildContext context, Widget? child);

  @override
  Widget build(BuildContext context) => buildWithChild(context, _child);

  @override
  SingleChildStatelessElement createElement() {
    return SingleChildStatelessElement(this);
  }
}

/// An [Element] that uses a [SingleChildStatelessWidget] as its configuration.
class SingleChildStatelessElement extends StatelessElement
    with SingleChildWidgetElementMixin {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildStatelessElement(SingleChildStatelessWidget super.widget);

  @override
  Widget build() {
    if (_parent != null) {
      return widget.buildWithChild(this, _parent!.injectedChild);
    }
    return super.build();
  }

  @override
  SingleChildStatelessWidget get widget =>
      super.widget as SingleChildStatelessWidget;
}

/// A [StatefulWidget] that is compatible with [Nested].
abstract class SingleChildStatefulWidget extends StatefulWidget
    implements SingleChildWidget {
  /// Creates a widget that has exactly one child widget.
  const SingleChildStatefulWidget({super.key, Widget? child}) : _child = child;

  final Widget? _child;

  @override
  SingleChildStatefulElement createElement() {
    return SingleChildStatefulElement(this);
  }
}

/// A [State] for [SingleChildStatefulWidget].
///
/// Do not override [build] and instead override [buildWithChild].
abstract class SingleChildState<T extends SingleChildStatefulWidget>
    extends State<T> {
  /// A [build] method that receives an extra `child` parameter.
  ///
  /// This method may be called with a `child` different from the parameter
  /// passed to the constructor of [SingleChildStatelessWidget].
  /// It may also be called again with a different `child`, without this widget
  /// being recreated.
  Widget buildWithChild(BuildContext context, Widget? child);

  @override
  Widget build(BuildContext context) => buildWithChild(context, widget._child);
}

/// An [Element] that uses a [SingleChildStatefulWidget] as its configuration.
class SingleChildStatefulElement extends StatefulElement
    with SingleChildWidgetElementMixin {
  /// Creates an element that uses the given widget as its configuration.
  SingleChildStatefulElement(SingleChildStatefulWidget super.widget);

  @override
  SingleChildStatefulWidget get widget =>
      super.widget as SingleChildStatefulWidget;

  @override
  SingleChildState<SingleChildStatefulWidget> get state =>
      super.state as SingleChildState<SingleChildStatefulWidget>;

  @override
  Widget build() {
    if (_parent != null) {
      return state.buildWithChild(this, _parent!.injectedChild);
    }
    return super.build();
  }
}

/// A [SingleChildWidget] that delegates its implementation to a callback.
///
/// It works like [Builder], but is compatible with [Nested].
class SingleChildBuilder extends SingleChildStatelessWidget {
  /// Creates a widget that delegates its build to a callback.
  ///
  /// The [builder] argument must not be null.
  const SingleChildBuilder({required this.builder, super.key, super.child});

  /// Called to obtain the child widget.
  ///
  /// The `child` parameter may be different from the one parameter passed to
  /// the constructor of [SingleChildBuilder].
  final Widget Function(BuildContext context, Widget? child) builder;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return builder(context, child);
  }
}

mixin SingleChildStatelessWidgetMixin
    implements StatelessWidget, SingleChildStatelessWidget {
  Widget? get child;

  @override
  Widget? get _child => child;

  @override
  SingleChildStatelessElement createElement() {
    return SingleChildStatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return buildWithChild(context, child);
  }
}

mixin SingleChildStatefulWidgetMixin on StatefulWidget
    implements SingleChildWidget {
  Widget? get child;

  @override
  _SingleChildStatefulMixinElement createElement() =>
      _SingleChildStatefulMixinElement(this);
}

mixin SingleChildStateMixin<T extends StatefulWidget> on State<T> {
  Widget buildWithChild(BuildContext context, Widget child);

  @override
  Widget build(BuildContext context) {
    return buildWithChild(
      context,
      (widget as SingleChildStatefulWidgetMixin).child!,
    );
  }
}

class _SingleChildStatefulMixinElement extends StatefulElement
    with SingleChildWidgetElementMixin {
  _SingleChildStatefulMixinElement(SingleChildStatefulWidgetMixin super.widget);

  @override
  SingleChildStatefulWidgetMixin get widget =>
      super.widget as SingleChildStatefulWidgetMixin;

  @override
  SingleChildStateMixin<StatefulWidget> get state =>
      super.state as SingleChildStateMixin<StatefulWidget>;

  @override
  Widget build() {
    if (_parent != null) {
      return state.buildWithChild(this, _parent!.injectedChild!);
    }
    return super.build();
  }
}

mixin SingleChildInheritedElementMixin
    on InheritedElement, SingleChildWidgetElementMixin {
  @override
  Widget build() {
    if (_parent != null) {
      return _parent!.injectedChild!;
    }
    return super.build();
  }
}
