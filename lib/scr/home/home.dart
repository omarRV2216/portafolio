import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portafolio/scr/appbar/appbar.dart';

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
    "Proyectos": GlobalKey(),
    "Habilidades": GlobalKey(),
    "Experiencia": GlobalKey(),
    "Contacto": GlobalKey(),
  };

  final List<String> _sections = [
    "Inicio",
    "Sobre mi",
    "Proyectos",
    "Habilidades",
    "Experiencia",
    "Contacto",
  ];

  void _onSelectionSelected(String section) {
    setState(() {
      _currentSection = section;
    });

    final key = _sectionKeys[section];
    if (key != null) {
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
    final themeData = _isDarkMode
        ? ThemeData.dark()
        : ThemeData.light();

    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo general
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
              _buildHomeContent(),
              _buildAboutMeContent(),
              _buildProjectsContent(),
              _buildSkillsContent(),
              _buildExperienceContent(),
              _buildContactContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Container(
      key: _sectionKeys["Inicio"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo unificado
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Foto de perfil arriba
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _isDarkMode
                      ? Colors.white.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: _isDarkMode
                    ? [Colors.grey[800]!, Colors.grey[600]!]
                    : [Colors.blue[300]!, Colors.blue[100]!],
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                "images/img.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Contenido textual abajo
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "¡Hola!",
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w300,
                  color: _isDarkMode ? Colors.white : Colors.black,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Soy Omar Aldair",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: _isDarkMode ? Colors.white : Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: _isDarkMode
                      ? [Colors.blue[300]!, Colors.purple[300]!]
                      : [Colors.blue[600]!, Colors.purple[600]!],
                ).createShader(bounds),
                child: Text(
                  "Desarrollador FullStack",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _onSelectionSelected("Proyectos");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: _isDarkMode ? Colors.white : Colors.black,
                  foregroundColor: _isDarkMode ? Colors.black : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: _isDarkMode
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Ver mis proyectos",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: _isDarkMode ? Colors.black : Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAboutMeContent() {
    return Container(
      key: _sectionKeys["Sobre mi"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo unificado
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sobre mí",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Soy un desarrollador apasionado por Flutter con experiencia en crear aplicaciones multiplataforma. Me encanta resolver problemas complejos y aprender nuevas tecnologías.",
            style: TextStyle(
              fontSize: 18,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem("2+", "Años de experiencia"),
              _buildInfoItem("15+", "Proyectos completados"),
              _buildInfoItem("5", "Tecnologías dominadas"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: _isDarkMode ? Colors.grey[400] : Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsContent() {
    return Container(
      key: _sectionKeys["Proyectos"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo unificado
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mis Proyectos",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          _buildProjectCard("Weather App", "Aplicación del clima con pronóstico extendido"),
          _buildProjectCard("Task Manager", "App de gestión de tareas con sincronización en la nube"),
          _buildProjectCard("E-commerce", "Tienda online con carrito de compras"),
        ],
      ),
    );
  }

  Widget _buildProjectCard(String title, String description) {
    return Card(
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      elevation: 2, // 👈 Sombra sutil para dar profundidad
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
        subtitle: Text(
          description,
          style: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.black),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
        onTap: () {},
      ),
    );
  }

  Widget _buildSkillsContent() {
    return Container(
      key: _sectionKeys["Habilidades"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo unificado
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mis Habilidades",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _buildSkillChip("Flutter"),
              _buildSkillChip("Dart"),
              _buildSkillChip("Firebase"),
              _buildSkillChip("API Integration"),
              _buildSkillChip("UI/UX Design"),
              _buildSkillChip("Git"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(
        skill,
        style: TextStyle(
          color: _isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      backgroundColor: _isDarkMode ? Colors.blue[800] : Colors.blue[100],
    );
  }

  Widget _buildExperienceContent() {
    return Container(
      key: _sectionKeys["Experiencia"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo unificado
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Experiencia",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          _buildExperienceItem("Desarrollador Flutter", "Empresa XYZ", "2022 - Presente"),
          _buildExperienceItem("Practicante de Desarrollo", "Empresa ABC", "2021 - 2022"),
        ],
      ),
    );
  }

  Widget _buildExperienceItem(String position, String company, String period) {
    return Card(
      color: _isDarkMode ? Colors.grey[800] : Colors.white,
      elevation: 2, // 👈 Sombra sutil
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          position,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        subtitle: Text(
          company,
          style: TextStyle(color: _isDarkMode ? Colors.grey[400] : Colors.black),
        ),
        trailing: Text(
          period,
          style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildContactContent() {
    return Container(
      key: _sectionKeys["Contacto"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white, // 👈 Fondo unificado
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Contacto",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "¿Interesado en trabajar juntos? ¡Contáctame!",
            style: TextStyle(
              fontSize: 18,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.email, size: 30, color: _isDarkMode ? Colors.white : Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.link, size: 30, color: _isDarkMode ? Colors.white : Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.work, size: 30, color: _isDarkMode ? Colors.white : Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 30),
          Text(
            "email@ejemplo.com",
            style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            "+1 (234) 567-8901",
            style: TextStyle(color: _isDarkMode ? Colors.white : Colors.black),
          ),
        ],
      ),
    );
  }
}