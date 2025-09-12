import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final List<String> sections;
  final Function(String) onSectionSelected;
  final String currentSection;
  final bool isDarkMode;
  final Function() onThemeChanged;
  final Color lightBackgroundColor;
  final Color darkBackgroundColor;
  final Color lightTextColor;
  final Color darkTextColor;
  final Color lightIndicatorColor;
  final Color darkIndicatorColor;

  const CustomAppBar({
    super.key,
    required this.sections,
    required this.onSectionSelected,
    required this.currentSection,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.lightBackgroundColor = Colors.white,
    this.darkBackgroundColor = Colors.black,
    this.lightTextColor = Colors.black,
    this.darkTextColor = Colors.white,
    this.lightIndicatorColor = Colors.blue,
    this.darkIndicatorColor = Colors.blueAccent,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.sections.indexOf(widget.currentSection);
    if (selectedIndex == -1) selectedIndex = 0;

    final backgroundColor = widget.isDarkMode
        ? widget.darkBackgroundColor
        : widget.lightBackgroundColor;

    final textColor = widget.isDarkMode
        ? widget.darkTextColor
        : widget.lightTextColor;

    final indicatorColor = widget.isDarkMode
        ? widget.darkIndicatorColor
        : widget.lightIndicatorColor;

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 4,
      title: null,
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SizedBox(
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("images/icon_flutter.png"),
                const Spacer(flex: 1),
                Expanded(
                  flex: 3,
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 500),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.sections.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            widget.onSectionSelected(widget.sections[index]);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: selectedIndex == index
                                      ? indicatorColor
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                widget.sections[index],
                                style: TextStyle(
                                  color: selectedIndex == index
                                      ? indicatorColor
                                      : textColor.withOpacity(0.7),
                                  fontWeight: selectedIndex == index
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(flex: 1),
                IconButton(
                  icon: Icon(
                    widget.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                    color: textColor,
                  ),
                  onPressed: widget.onThemeChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}