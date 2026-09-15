import 'package:flutter/material.dart';
import 'package:portafolio/scr/appbar/appbar.dart';
import 'package:portafolio/scr/home/widgets/about_section.dart';
import 'package:portafolio/scr/home/widgets/experience_section.dart';
import 'package:portafolio/scr/home/widgets/hero_section.dart';
import 'package:portafolio/scr/home/widgets/skills_section.dart';
import 'package:portafolio/scr/utils/url_launcher_helper.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  String _currentSection = "Inicio";
  bool _isDarkMode = false;

  final Map<String, GlobalKey> _sectionKeys = {
    "Inicio": GlobalKey(),
    "Sobre mi": GlobalKey(),
    "Habilidades": GlobalKey(),
    "Experiencia": GlobalKey(),
  };

  final List<String> _sections = [
    "Inicio",
    "Sobre mi",
    "Habilidades",
    "Experiencia",
  ];

  bool _isProgrammaticScroll = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // ============================================================
  // SCROLL: detecta la sección visible
  // ============================================================
  void _onScroll() {
    if (_isProgrammaticScroll) return;

    final double appBarHeight =
        kToolbarHeight + MediaQuery.of(context).padding.top;

    String? visibleSection;

    for (final entry in _sectionKeys.entries) {
      final ctx = entry.value.currentContext;
      if (ctx == null) continue;

      final box = ctx.findRenderObject() as RenderBox;
      final double sectionTop = box.localToGlobal(Offset.zero).dy;

      if (sectionTop <= appBarHeight + 20) {
        visibleSection = entry.key;
      }
    }

    if (visibleSection != null && visibleSection != _currentSection) {
      setState(() => _currentSection = visibleSection!);
    }
  }

  // ============================================================
  // SCROLL: al hacer clic en una sección
  // ============================================================
  void _onSelectionSelected(String section) {
    if (!mounted) return;

    setState(() => _currentSection = section);

    final key = _sectionKeys[section];
    if (key == null || key.currentContext == null) return;
    if (!_scrollController.hasClients) return;

    _isProgrammaticScroll = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_scrollController.hasClients) {
        _isProgrammaticScroll = false;
        return;
      }

      final double appBarHeight =
          kToolbarHeight + MediaQuery.of(context).padding.top;

      final box = key.currentContext!.findRenderObject() as RenderBox;
      final double targetOffset = _scrollController.offset +
          box.localToGlobal(Offset.zero).dy -
          appBarHeight -
          16;

      _scrollController
          .animateTo(
        targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      )
          .then((_) {
        _isProgrammaticScroll = false;
      });
    });
  }

  void _toggleTheme() {
    setState(() => _isDarkMode = !_isDarkMode);
  }

  // ============================================================
  // DRAWER LATERAL IZQUIERDO (menú de secciones)
  // ============================================================
  Widget _buildDrawer(BuildContext context) {
    final fg = _isDarkMode ? Colors.white : Colors.black;
    final accent = _isDarkMode ? Colors.blueAccent : Colors.blue;

    return Drawer(
      backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Header ===
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/icon_flutter.png",
                    height: 32,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.code, color: fg, size: 32),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Menú",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: fg,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // === Secciones ===
            ..._sections.map((section) {
              final bool selected = section == _currentSection;
              return ListTile(
                leading: Icon(
                  _iconForSection(section),
                  color: selected ? accent : fg.withOpacity(0.6),
                ),
                title: Text(
                  section,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                    selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? accent : fg,
                  ),
                ),
                selected: selected,
                selectedTileColor: accent.withOpacity(0.1),
                onTap: () async {
                  Navigator.of(context).pop();
                  await Future.delayed(const Duration(milliseconds: 300));
                  if (!mounted) return;
                  _onSelectionSelected(section);
                },
              );
            }).toList(),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  IconData _iconForSection(String section) {
    switch (section) {
      case "Inicio":
        return Icons.home_outlined;
      case "Sobre mi":
        return Icons.person_outline;
      case "Habilidades":
        return Icons.code;
      case "Experiencia":
        return Icons.work_outline;
      default:
        return Icons.circle_outlined;
    }
  }

  Widget _buildSocialFABs() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: "linkedin_fab",
          mini: true,
          backgroundColor: const Color(0xFF0A66C2),
          tooltip: "LinkedIn",
          onPressed: () {
            launchUrl(
              "https://www.linkedin.com/in/omar-aldair-rodriguez-vicente-a97785268/",
            );
          },
          child: Image.asset(
            "assets/icons/linke.png",
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.link,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(height: 12),

        FloatingActionButton(
          heroTag: "github_fab",
          mini: true,
          backgroundColor: const Color(0xFFFFFFFF),
          tooltip: "GitHub",
          onPressed: () {
            launchUrl("https://github.com/omarRV2216");
          },
          child: Image.asset(
            "assets/icons/icon_github.png",
            width: 24,
            height: 24,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.code,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,

        // 🔧 Drawer (menú lateral izquierdo)
        drawer: _buildDrawer(context),

        appBar: CustomAppBar(
          sections: _sections,
          onSectionSelected: _onSelectionSelected,
          currentSection: _currentSection,
          isDarkMode: _isDarkMode,
          onThemeChanged: _toggleTheme,
        ),

        // 🔧 FABs de redes sociales (borde derecho)
        floatingActionButton: _buildSocialFABs(),

        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              HeroSection(
                key: _sectionKeys["Inicio"],
                isDarkMode: _isDarkMode,
                onSeeProjects: () => _onSelectionSelected("Experiencia"),
              ),
              const SizedBox(height: 8),
              AboutSection(
                key: _sectionKeys["Sobre mi"],
                isDarkMode: _isDarkMode,
              ),
              const SizedBox(height: 8),
              SkillsSection(
                key: _sectionKeys["Habilidades"],
                isDarkMode: _isDarkMode,
              ),
              const SizedBox(height: 300),
              ExperienceSection(
                key: _sectionKeys["Experiencia"],
                isDarkMode: _isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}