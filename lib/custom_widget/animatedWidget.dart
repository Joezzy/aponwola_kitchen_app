import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimatedContainerWrapper extends StatelessWidget {
  const AnimatedContainerWrapper({
     this.closedBuilder,
    required this.transitionType,
     this.onClosed,
    this.child,
  });

  final CloseContainerBuilder? closedBuilder;
  final ContainerTransitionType transitionType;
  final ClosedCallback<bool?>? onClosed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return child!;
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder!,
    );
  }
}
