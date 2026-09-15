import 'package:flutter/material.dart';
import 'package:portafolio/scr/appbar/appbar.dart';
import 'package:portafolio/scr/home/widgets/about_section.dart';
import 'package:portafolio/scr/home/widgets/experience_section.dart';
import 'package:portafolio/scr/home/widgets/hero_section.dart';
import 'package:portafolio/scr/home/widgets/skills_section.dart';

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

  void _onScroll() {
    if (_isProgrammaticScroll) return; // no interferir con el clic

    final double scrollPosition = _scrollController.offset;
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

  // 🔹 Scroll al hacer clic
  void _onSelectionSelected(String section) {
    if (!mounted) return;

    setState(() => _currentSection = section);

    final key = _sectionKeys[section];
    if (key == null || key.currentContext == null) return;
    if (!_scrollController.hasClients) return;

    _isProgrammaticScroll = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (!_scrollController.hasClients) return;

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

  @override
  Widget build(BuildContext context) {
    final themeData = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData,
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white,
        appBar: CustomAppBar(
          sections: _sections,
          onSectionSelected: _onSelectionSelected,
          currentSection: _currentSection,
          isDarkMode: _isDarkMode,
          onThemeChanged: _toggleTheme,
        ),
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