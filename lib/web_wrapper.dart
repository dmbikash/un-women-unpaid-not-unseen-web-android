import 'package:flutter/material.dart';

class WebWrapper extends StatelessWidget {
  final List<Widget> children;

  const WebWrapper({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobileOrPortrait = size.width < 600; // threshold for mobile/tablet

    if (isMobileOrPortrait) {
      // Mobile / small screen layout → no side flex
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        ),
      );
    } else {
      // Web / large screen layout → with side flex
      return Row(
        children: [
          const Expanded(flex: 2, child: SizedBox()),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              ),
            ),
          ),
          const Expanded(flex: 2, child: SizedBox()),
        ],
      );
    }
  }
}
