import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portafolio/scr/appbar/appbar.dart';
import 'dart:html' as html;

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
      color: _isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                child: const Text(
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
                  _onSelectionSelected("Experiencia");
                },
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
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
              _buildInfoCard("2+", "Años de\nExperiencia",
                  Icons.work_history, Colors.blue),
              const SizedBox(width: 20),
              _buildInfoCard("6+", "Proyectos\nCompletados",
                  Icons.folder_open, Colors.purple),
              const SizedBox(width: 20),
              _buildInfoCard("5+", "Tecnologías\nDominadas",
                  Icons.code, Colors.orange),
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

  Widget _buildInfoCard(
      String number, String label, IconData icon, Color color) {
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
          color: _isDarkMode
              ? Colors.blue.withOpacity(0.3)
              : Colors.blue.withOpacity(0.2),
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
                          skills: [
                            "React",
                            "JavaScript",
                            "Tailwind CSS",
                            "Bootstrap"
                          ],
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
                      Expanded(child: Container()),
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
        color: _isDarkMode ? Colors.grey[850] : Colors.grey[50],
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
            children:
            skills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    Color getSkillColor() {
      if (skill.contains("Flutter") ||
          skill.contains("Dart") ||
          skill.contains("JSON") ||
          skill.contains("Web Service")) {
        return Colors.blue.shade400;
      }
      if (skill.contains("PHP") ||
          skill.contains("Laravel") ||
          skill.contains("Livewire") ||
          skill.contains("DomPdf")) {
        return Colors.purple.shade400;
      }
      if (skill.contains("React") ||
          skill.contains("JavaScript") ||
          skill.contains("Tailwind") ||
          skill.contains("Bootstrap")) {
        return Colors.orange.shade400;
      }
      if (skill.contains("MariaDB") || skill.contains("DBaver")) {
        return Colors.green.shade400;
      }
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: _isDarkMode,
                          logo: Container(
                            width: double.infinity,
                            height: 150,
                            child: Image.asset(
                              "images/footer_logo.png",
                              fit: BoxFit.contain,
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
                          company: "EcoBrush - Page",
                          position: "Desarrollador FullStack",
                          description:
                          "Lideré el desarrollo y la mejora continua de la plataforma web de EcoBrush, "
                              "gestionando la comunicación directa con clientes, coordinando reuniones de levantamiento "
                              "de requerimientos y proponiendo iniciativas de mejora para optimizar la experiencia del usuario"
                              " y los procesos internos.",
                          url: "https://ecobrush.mx",
                          icon: Icons.work,
                          color: Colors.blue,
                          technologies: const [
                            "Flutter",
                            "Dart",
                            "Firebase",
                            "Git"
                          ],
                          period: '2025',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: _isDarkMode,
                          logo: Container(
                            width: double.infinity,
                            height: 150,
                            child: Image.asset(
                              "images/footer_logo.png",
                              fit: BoxFit.contain,
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
                          company: "EcoBrush - LandingPage",
                          position: "Desarrollador Flutter Senior",
                          period: "2023 - Presente",
                          description:
                          "Colaboré en el desarrollo de la landing page de EcoBrush, implementando un diseño moderno y"
                              " responsive orientado a la conversión, optimizando el rendimiento de carga y"
                              " garantizando una experiencia de usuario fluida en todos los dispositivos.",
                          url: "https://ecobrush.mx",
                          icon: Icons.work,
                          color: Colors.blue,
                          technologies: const [
                            "Flutter",
                            "Dart",
                            "Firebase",
                            "Git"
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: _isDarkMode,
                          company: "Amazon",
                          position: "Backend Developer",
                          period: "2021 - 2022",
                          description:
                          "Diseñé e implementé microservicios escalables con Laravel, optimizando consultas SQL y mejorando el rendimiento de la base de datos.",
                          url: "",
                          icon: Icons.cloud,
                          color: Colors.orange,
                          technologies: const [
                            "PHP",
                            "Laravel",
                            "MariaDB",
                            "Redis"
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: _isDarkMode,
                          company: "Tesla",
                          position: "Frontend Developer",
                          period: "2020 - 2021",
                          description:
                          "Creé interfaces de usuario modernas y responsivas con React y Tailwind CSS, mejorando la experiencia de usuario.",
                          url: "",
                          icon: Icons.dashboard,
                          color: Colors.green,
                          technologies: const [
                            "React",
                            "JavaScript",
                            "Tailwind",
                            "Bootstrap"
                          ],
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
}

// ============================================================
// WIDGET ExperienceCard CON "LEER MÁS / LEER MENOS"
// ============================================================
class ExperienceCard extends StatefulWidget {
  final Widget? logo;
  final String company;
  final String position;
  final String period;
  final String description;
  final String url;
  final IconData icon;
  final Color color;
  final List<String> technologies;
  final bool isDarkMode;

  const ExperienceCard({
    super.key,
    this.logo,
    required this.company,
    required this.position,
    required this.period,
    required this.description,
    required this.url,
    required this.icon,
    required this.color,
    required this.technologies,
    required this.isDarkMode,
  });

  @override
  State<ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _expanded = false;

  void _launchUrl(String url) {
    if (url.isEmpty) return;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    final bool hasUrl = widget.url.isNotEmpty;
    final bool dark = widget.isDarkMode;

    Widget techChip(String tech) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: dark
              ? widget.color.withOpacity(0.2)
              : widget.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.color.withOpacity(0.3),
            width: 0.8,
          ),
        ),
        child: Text(
          tech,
          style: TextStyle(
            fontSize: 11,
            color: dark ? Colors.white : widget.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: dark ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: dark ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: dark
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
          if (widget.logo != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: widget.logo,
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(widget.icon,
                          color: widget.color, size: 24),
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
                                  widget.company,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: dark ? Colors.white : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (hasUrl) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.open_in_new,
                                  color: widget.color,
                                  size: 16,
                                ),
                              ],
                            ],
                          ),
                          Text(
                            widget.position,
                            style: TextStyle(
                              fontSize: 13,
                              color: dark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: dark ? Colors.grey[500] : Colors.grey[400],
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.period,
                      style: TextStyle(
                        fontSize: 12,
                        color: dark ? Colors.grey[400] : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // ==============================
                // DESCRIPCIÓN CON LEER MÁS
                // ==============================
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 250),
                  crossFadeState: _expanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  firstChild: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: dark ? Colors.grey[300] : Colors.grey[700],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  secondChild: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 13,
                      height: 1.5,
                      color: dark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ),

                // Botón Leer más / Leer menos
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () =>
                        setState(() => _expanded = !_expanded),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 28),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _expanded ? "Leer menos" : "Leer más",
                          style: TextStyle(
                            fontSize: 12,
                            color: widget.color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Icon(
                          _expanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: widget.color,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children:
                  widget.technologies.map(techChip).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (hasUrl) {
      return InkWell(
        onTap: () => _launchUrl(widget.url),
        borderRadius: BorderRadius.circular(16),
        child: cardContent,
      );
    }
    return cardContent;
  }
}