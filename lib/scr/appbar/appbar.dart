import 'package:flutter/material.dart';

import '../utils/url_launcher_helper.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> sections;
  final Function(String) onSectionSelected;
  final String currentSection;
  final bool isDarkMode;
  final VoidCallback onThemeChanged;

  const CustomAppBar({
    super.key,
    required this.sections,
    required this.onSectionSelected,
    required this.currentSection,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final bg = isDarkMode ? Colors.black : Colors.white;
    final fg = isDarkMode ? Colors.white : Colors.black;
    final accent = isDarkMode ? Colors.blueAccent : Colors.blue;

    return AppBar(
      backgroundColor: bg,
      elevation: 2,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Row(
        children: [
          // === LOGO (izquierda) ===
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Image.asset(
              "assets/images/icon_flutter.png",
              height: 28,
            ),
          ),

          // === OPCIONES (centradas) ===
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sections.map((section) {
                final bool selected = section == currentSection;
                return GestureDetector(
                  onTap: () => onSectionSelected(section),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          section,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                            selected ? FontWeight.bold : FontWeight.normal,
                            color: selected ? accent : fg.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Línea indicadora debajo del texto seleccionado
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          height: 2,
                          width: selected ? 20 : 0,
                          decoration: BoxDecoration(
                            color: accent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              tooltip: "Linkedin",
              icon: Image.asset(
                "assets/icons/linke.png",
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.code, color: fg, size: 22);
                },
              ),
              onPressed: () {
                launchUrl("https://www.linkedin.com/in/omar-aldair-rodriguez-vicente-a97785268/");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              tooltip: "GitHub",
              icon: Image.asset(
                "assets/icons/icon_github.png",
                width: 22,
                height: 22,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.code, color: fg, size: 22);
                },
              ),
              onPressed: () {
                launchUrl("https://github.com/omarRV2216");
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: fg,
                size: 20,
              ),
              onPressed: onThemeChanged,
            ),
          ),
        ],
      ),
    );
  }
}