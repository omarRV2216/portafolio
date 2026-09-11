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

  void _onSelectionSelected(String section) {
    setState(() {
      _currentSection = section;
    });

    final key = _sectionKeys[section];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              AboutSection(
                key: _sectionKeys["Sobre mi"],
                isDarkMode: _isDarkMode,
              ),
              SkillsSection(
                key: _sectionKeys["Habilidades"],
                isDarkMode: _isDarkMode,
              ),
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