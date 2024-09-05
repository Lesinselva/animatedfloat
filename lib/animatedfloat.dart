library animatedfloat;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAnimatedFloatingActionButton extends StatefulWidget {
  final String svgPath;
  final String text;
  final VoidCallback onTap;
  final ScrollController scrollController;

  const CustomAnimatedFloatingActionButton({
    super.key,
    required this.svgPath,
    required this.text,
    required this.onTap,
    required this.scrollController,
  });

  @override
  _CustomAnimatedFloatingActionButtonState createState() =>
      _CustomAnimatedFloatingActionButtonState();
}

class _CustomAnimatedFloatingActionButtonState
    extends State<CustomAnimatedFloatingActionButton> {
  bool isScrollingDown = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isScrollingDown) {
        setState(() {
          isScrollingDown = true;
        });
      }
    } else if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isScrollingDown) {
        setState(() {
          isScrollingDown = false;
        });
      }
    }
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 50,
      width: isScrollingDown ? 50 : 145,
      decoration: BoxDecoration(
        color: const Color(0x7704938D),
        borderRadius: BorderRadius.circular(11),
      ),
      clipBehavior: Clip.hardEdge,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(11),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: SvgPicture.asset(
                  widget.svgPath,
                  width: 24,
                  height: 24,
                  color: Colors.black,
                ),
              ),
              if (!isScrollingDown)
                Padding(
                  padding: const EdgeInsets.only(right: 4, left: 2),
                  child: Text(
                    widget.text,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
