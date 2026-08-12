import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portafolio/scr/appbar/appbar.dart';
import 'dart:html' as html; // 👈 Import para web


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
              _buildSkillsContent(),
              _buildExperienceContent(),
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
      color: _isDarkMode ? Colors.grey[900] : Colors.white,
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
            "Soy desarrollador fullstack apasionado la experiencia en desarrollar y "
                "crear aplicaciones multiplataforma. Me encanta resolver problemas complejos y "
                "aprender nuevas tecnologías.",
            style: TextStyle(
              fontSize: 18,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoCard(
                "2+",
                "Años de\nExperiencia",
                Icons.work_history,
                Colors.blue,
              ),
              const SizedBox(width: 20),
              _buildInfoCard(
                "6+",
                "Proyectos\nCompletados",
                Icons.folder_open,
                Colors.purple,
              ),
              const SizedBox(width: 20),
              _buildInfoCard(
                "5+",
                "Tecnologías\nDominadas",
                Icons.code,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 30),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            alignment: WrapAlignment.center,
            children: [
              _buildInterestChip("🚀 Innovación"),
              _buildInterestChip("💡 Aprendizaje continuo"),
              _buildInterestChip("🤝 Trabajo en equipo"),
              _buildInterestChip("🎯 Resolución de problemas"),
              _buildInterestChip("📱 Desarrollo multiplataforma"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String number, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _isDarkMode
                ? Colors.black.withOpacity(0.2)
                : Colors.grey.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            number,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInterestChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isDarkMode
              ? [Colors.blue.withOpacity(0.2), Colors.purple.withOpacity(0.2)]
              : [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: _isDarkMode ? Colors.blue.withOpacity(0.3) : Colors.blue.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: _isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSkillsContent() {
    return Container(
      key: _sectionKeys["Habilidades"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildSkillCategory(
                          title: "Desarrollo Móvil",
                          skills: ["Flutter", "Dart", "JSON", "Web Service"],
                          icon: Icons.phone_android,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildSkillCategory(
                          title: "Desarrollo Web",
                          skills: ["PHP", "Laravel", "Livewire", "DomPdf"],
                          icon: Icons.web,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: _buildSkillCategory(
                          title: "Frontend",
                          skills: ["React", "JavaScript", "Tailwind CSS", "Bootstrap"],
                          icon: Icons.palette,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildSkillCategory(
                          title: "Base de Datos",
                          skills: ["MariaDB", "DBaver"],
                          icon: Icons.storage,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),


                  Row(
                    children: [
                      Expanded(
                        child: _buildSkillCategory(
                          title: "Pruebas de API y Repositorios",
                          skills: ["Postman", "GitHub", "GitLab"],
                          icon: Icons.build,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory({
    required String title,
    required List<String> skills,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _isDarkMode
            ? Colors.grey[850]
            : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isDarkMode ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    // Colores según categoría
    Color getSkillColor() {
      // Móvil
      if (skill.contains("Flutter") || skill.contains("Dart") ||
          skill.contains("JSON") || skill.contains("Web Service")) {
        return Colors.blue.shade400;
      }
      // Web
      if (skill.contains("PHP") || skill.contains("Laravel") ||
          skill.contains("Livewire") || skill.contains("DomPdf")) {
        return Colors.purple.shade400;
      }
      // Frontend
      if (skill.contains("React") || skill.contains("JavaScript") ||
          skill.contains("Tailwind") || skill.contains("Bootstrap")) {
        return Colors.orange.shade400;
      }
      // Base de datos
      if (skill.contains("MariaDB") || skill.contains("DBaver")) {
        return Colors.green.shade400;
      }
      // Herramientas
      if (skill.contains("Postman") || skill.contains("Git")) {
        return Colors.red.shade400;
      }
      return Colors.grey.shade400;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: _isDarkMode
            ? getSkillColor().withOpacity(0.2)
            : getSkillColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: getSkillColor().withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: _isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildExperienceContent() {
    return Container(
      key: _sectionKeys["Experiencia"],
      height: MediaQuery.of(context).size.height,
      color: _isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título con línea decorativa
          Column(
            children: [
              Text(
                "Experiencia",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Grid de experiencias en 2 columnas
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Fila 1: Experiencia 1 y 2
                  Row(
                    children: [
                      Expanded(
                        child: _buildExperienceCard(
                          logo: Container(
                            width: double.infinity,
                            height: 150, // 👈 Altura más grande para mejor visualización
                            child: Image.asset(
                              "images/footer_logo.png",
                              fit: BoxFit.contain, // 👈 Cambiado a 'contain' para que no se corte
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 40,
                                  ),
                                );
                              },
                            ),
                          ),
                          company: "EcoBrush",
                          position: "Desarrollador Flutter Senior",
                          period: "2023 - Presente",
                          description:
                          "Lideré el desarrollo de aplicaciones móviles multiplataforma con Flutter, implementando arquitectura MVC y optimizando el rendimiento.",
                          url: "http://ecobrush.com.mx/",
                          icon: Icons.work,
                          color: Colors.blue,
                          technologies: ["Flutter", "Dart", "Firebase", "Git"],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildExperienceCard(
                          company: "Microsoft",
                          position: "Desarrollador Fullstack",
                          period: "2022 - 2023",
                          description:
                          "Desarrollé soluciones web con Laravel y React, implementando APIs RESTful y sistemas de autenticación empresarial.",
                          url: "",
                          icon: Icons.code,
                          color: Colors.purple,
                          technologies: ["Laravel", "React", "PHP", "MySQL"],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Fila 2: Experiencia 3 y 4
                  Row(
                    children: [
                      Expanded(
                        child: _buildExperienceCard(
                          company: "Amazon",
                          position: "Backend Developer",
                          period: "2021 - 2022",
                          description:
                          "Diseñé e implementé microservicios escalables con Laravel, optimizando consultas SQL y mejorando el rendimiento de la base de datos.",
                          url: "",
                          icon: Icons.cloud,
                          color: Colors.orange,
                          technologies: ["PHP", "Laravel", "MariaDB", "Redis"],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildExperienceCard(
                          company: "Tesla",
                          position: "Frontend Developer",
                          period: "2020 - 2021",
                          description:
                          "Creé interfaces de usuario modernas y responsivas con React y Tailwind CSS, mejorando la experiencia de usuario.",
                          url: "",
                          icon: Icons.dashboard,
                          color: Colors.green,
                          technologies: ["React", "JavaScript", "Tailwind", "Bootstrap"],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard({
    required String company,
    required String position,
    required String period,
    required String description,
    required String url,
    required IconData icon,
    required Color color,
    required List<String> technologies,
    Widget? logo, // 👈 Logo opcional
  }) {
    // Verificar si tiene URL para hacerla clicable
    final bool hasUrl = url.isNotEmpty;

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: _isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: _isDarkMode
                ? Colors.black.withOpacity(0.3)
                : Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // IMAGEN GRANDE ARRIBA (si existe)
          // ==========================================
          if (logo != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 120, // 👈 Altura de la imagen
                child: logo,
              ),
            ),
          ],

          // ==========================================
          // CONTENIDO DE LA TARJETA
          // ==========================================
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Encabezado con ícono y empresa
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  company,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: _isDarkMode ? Colors.white : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Mostrar ícono de enlace SOLO si tiene URL
                              if (hasUrl) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.open_in_new,
                                  color: color,
                                  size: 16,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            position,
                            style: TextStyle(
                              fontSize: 13,
                              color: _isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Período
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: _isDarkMode ? Colors.grey[500] : Colors.grey[400],
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 12,
                        color: _isDarkMode ? Colors.grey[400] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Descripción
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: _isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Tecnologías usadas
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: technologies.map((tech) => _buildTechChip(tech, color)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // Si tiene URL, envolver en InkWell para hacerla clicable
    if (hasUrl) {
      return InkWell(
        onTap: () {
          _launchUrl(url);
        },
        borderRadius: BorderRadius.circular(16),
        child: cardContent,
      );
    }

    // Si no tiene URL, devolver solo el contenido
    return cardContent;
  }

  Widget _buildTechChip(String tech, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _isDarkMode ? color.withOpacity(0.2) : color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 0.8,
        ),
      ),
      child: Text(
        tech,
        style: TextStyle(
          fontSize: 11,
          color: _isDarkMode ? Colors.white : color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

// ✅ FUNCIÓN DEFINITIVA - SOLO USA DART:HTML
  void _launchUrl(String url) {
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        url = 'https://$url';
      }
      html.window.open(url, '_blank');
  }

}