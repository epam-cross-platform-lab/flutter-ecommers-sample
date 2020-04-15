import 'package:flutter/widgets.dart';

class SlideMenu extends StatefulWidget {
  const SlideMenu(
      {Key key,
      this.child,
      this.menuItems,
      this.opened,
      this.closed,
      this.dismissed,
      this.dismissItem})
      : super(key: key);

  final Widget child;
  final Widget dismissItem;
  final Function opened;
  final Function closed;
  final List<Widget> menuItems;
  final Function() dismissed;

  @override
  SlideMenuState createState() => SlideMenuState();
}

class SlideMenuState extends State<SlideMenu> with TickerProviderStateMixin {
  AnimationController _partiallyOpenController;
  bool _isDissmissableEnabled = true;
  Animation<Offset> _partiallyOpenAnimation;
  AnimationController _fullOpenController;
  Animation<Offset> _fullOpenAnimation;

  @override
  void initState() {
    _partiallyOpenController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
    _partiallyOpenAnimation = Tween(begin: const Offset(0.0, 0.0), end: const Offset(-0.2, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_partiallyOpenController));
    _fullOpenController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _fullOpenAnimation = Tween(begin: const Offset(0.0, 0.0), end: const Offset(-1, 0.0))
        .animate(CurveTween(curve: Curves.decelerate).animate(_fullOpenController));

    super.initState();
  }

  @override
  void dispose() {
    _partiallyOpenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragUpdate: (data) {
          if (_isDissmissableEnabled) {
            _fullOpenController.value -= data.primaryDelta / context.size.width;
          }
        },
        onHorizontalDragEnd: (data) {
          if (_isDissmissableEnabled) {
            _onFullHorizontalDragEnd(data);
          }
        },
        onTap: (){
          if(!_isDissmissableEnabled){
            closeMenu();
          }
        },
        child: Stack(children: <Widget>[
          SlideTransition(
              position: _fullOpenAnimation,
              child: SlideTransition(position: _partiallyOpenAnimation, child: widget.child)),
          Positioned.fill(
              child: LayoutBuilder(
                  builder: (context, constraint) => AnimatedBuilder(
                      animation: _fullOpenAnimation,
                      builder: (context, child) => AnimatedBuilder(
                          animation: _partiallyOpenController,
                          builder: (context, child) => Stack(children: <Widget>[
                                Positioned(
                                    right: .0,
                                    top: .0,
                                    bottom: .0,
                                    width: constraint.maxWidth * _getValue() * -1,
                                    child: _isDissmissableEnabled
                                        ? widget.dismissItem
                                        : Row(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: widget.menuItems
                                                .map((child) => Expanded(child: child))
                                                .toList()))
                              ])))))
        ]));
  }

  void openMenu() {
    _isDissmissableEnabled = false;
    _partiallyOpenController.animateTo(1.0);
    widget.opened?.call();
  }

  void closeMenu() {
    _isDissmissableEnabled = true;
    _partiallyOpenController.animateTo(.0);
    widget.closed?.call();
  }

  void _onFullHorizontalDragEnd(DragEndDetails data) {
    if (_fullOpenController.value >= .3) {
      _openFull();
    } else {
      _closeFull();
    }
  }

  void _openFull() {
    _fullOpenController.animateTo(1.0).whenComplete(() => widget.dismissed?.call());
  }

  void _closeFull() {
    _isDissmissableEnabled = true;
    _fullOpenController.animateTo(.0, duration: const Duration(milliseconds: 300));
  }

  double _getValue() {
    return _isDissmissableEnabled ? _fullOpenAnimation.value.dx : _partiallyOpenAnimation.value.dx;
  }
}
