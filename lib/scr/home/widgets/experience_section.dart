import 'package:flutter/material.dart';
import 'package:portafolio/scr/widgets/experience_card.dart';

class ExperienceSection extends StatelessWidget {
  final bool isDarkMode;

  const ExperienceSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      width: double.infinity,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // === Título ===
          Column(
            children: [
              Text(
                "Experiencia",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
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

          // === Grid responsivo con Wrap (altura libre) ===
          LayoutBuilder(
            builder: (context, constraints) {
              // Decidir columnas según el ancho
              int columns;
              if (constraints.maxWidth >= 1200) {
                columns = 3;
              } else if (constraints.maxWidth >= 800) {
                columns = 2;
              } else if (constraints.maxWidth >= 500) {
                columns = 2;
              } else {
                columns = 1;
              }

              // Calcular ancho de cada tarjeta
              const spacing = 20.0;
              final totalSpacing = spacing * (columns - 1);
              final cardWidth =
                  (constraints.maxWidth - totalSpacing) / columns;

              final cards = _buildExperienceCards(context);

              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: cards
                    .map((card) => SizedBox(
                  width: cardWidth,
                  // Sin height → altura libre por tarjeta
                  child: card,
                ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LISTA DE TARJETAS
  // ============================================================
  List<Widget> _buildExperienceCards(BuildContext context) {
    return [
      // ============ 1. All American ============
      ExperienceCard(
        isDarkMode: isDarkMode,
        logo: _buildLogo3(),
        company: "All American Marketing and Services Business",
        position: "Desarrollador FullStack",
        description:
        "• Lideré múltiples proyectos de desarrollo web para clientes en Texas, Indiana, California y Carolina del Norte, trabajando de manera remota.\n\n"
            "• Dirigí reuniones de levantamiento de requerimientos y mantuve la comunicación directa con los clientes.\n\n"
            "• Coordiné la comunicación entre los equipos de desarrollo y marketing.\n\n"
            "• Colaboré en la migración de páginas obsoletas usando tecnología React.\n\n"
            "• Propuse e implementé iniciativas de mejora continua para optimizar la experiencia del usuario y los procesos internos.",
        url: "https://tx-mf25.allamericanmbs.com/",
        icon: Icons.work,
        color: Colors.blue,
        technologies: const [
          "Laravel", "PHP", "Teams", "Flutter", "React",
          "Postman", "MariaDB", "GitLab", "MVC", "Livewire",
        ],
        period: '2025 - 2026',
      ),

      // ============ 2. Cybac TI ============
      ExperienceCard(
        isDarkMode: isDarkMode,
        logo: _buildLogo2(),
        company: "Cybac TI",
        position: "Desarrollador FullStack",
        description:
        "• Lideré el desarrollo y la mejora continua de la plataforma web de EcoBrush.\n\n"
            "• Gestioné la comunicación directa con clientes y coordiné reuniones de levantamiento de requerimientos.\n\n"
            "• Propuse e implementé iniciativas de mejora para optimizar la experiencia del usuario y los procesos internos.",
        url: "https://grupocybac.com",
        icon: Icons.work,
        color: Colors.blue,
        technologies: const [
          "Laravel", "PHP", "MVC", "Slack", "GitHub", "MySQL", "React", "Livewire",
        ],
        period: '2024 - 2025',
      ),

      // ============ 3. EcoBrush Page ============
      ExperienceCard(
        isDarkMode: isDarkMode,
        logo: _buildLogo(),
        company: "EcoBrush - Page",
        position: "Desarrollador FullStack",
        description:
        "• Lideré el desarrollo y la mejora continua de la plataforma web de EcoBrush, gestionando el ciclo completo de desarrollo.\n\n"
            "• Coordiné reuniones de levantamiento de requerimientos directamente con los clientes para definir alcances y prioridades.\n\n"
            "• Propuse e implementé iniciativas de mejora continua para optimizar la experiencia del usuario y los procesos internos.\n\n"
            "• Desarrollé módulos completos con Laravel 10, Livewire y Bootstrap, integrando generación de reportes PDF con DomPDF.\n\n"
            "• Gestioné la base de datos MariaDB y el control de versiones con GitLab.",
        url: "https://ecobrush.mx",
        icon: Icons.work,
        color: Colors.blue,
        technologies: const [
          "Laravel", "PHP", "Livewire", "Bootstrap", "DomPDF",
          "MariaDB", "GitHub", "Zoom",
        ],
        period: '2024 - 2025',
      ),

      // ============ 4. EcoBrush LandingPage ============
      ExperienceCard(
        isDarkMode: isDarkMode,
        logo: _buildLogo(),
        company: "EcoBrush - LandingPage",
        position: "Desarrollador FullStack",
        period: "2024 - 2025",
        description:
        "• Desarrollé la landing page oficial de EcoBrush con Flutter Web, implementando un diseño moderno y totalmente responsive.\n\n"
            "• Optimicé el rendimiento de carga reduciendo tiempos de renderizado y mejorando la puntuación de rendimiento.\n\n"
            "• Garanticé una experiencia de usuario fluida en dispositivos móviles, tablets y desktop.\n\n"
            "• Implementé el diseño orientado a conversión, alineado con la identidad visual de la marca.\n\n"
            "• Gestioné el despliegue y control de versiones con Git y Firebase Hosting.",
        url: "https://ecobrush.mx",
        icon: Icons.work,
        color: Colors.blue,
        technologies: const [
          "Flutter", "Dart", "Firebase", "Git", "Web",
        ],
      ),

      // ============ 5. CFE ============
      ExperienceCard(
        isDarkMode: isDarkMode,
        logo: _buildLogo4(),
        company: "Comisión Federal de Electricidad",
        position: "Desarrollador FullStack (Prácticas Profesionales)",
        description:
        "• Desarrollé una aplicación móvil en Flutter para la prevención de riesgos en entornos de trabajo, implementando formularios dinámicos y validaciones en tiempo real.\n\n"
            "• Administré la coordinación de flotillas de trabajadores de campo, gestionando rutas, horarios y asignación de tareas.\n\n"
            "• Coordiné reuniones de trabajo con diferentes áreas para el levantamiento de requerimientos y seguimiento de proyectos.\n\n"
            "• Realicé mantenimiento preventivo y correctivo a equipos de cómputo, garantizando la continuidad operativa.\n\n"
            "• Gestioné tareas administrativas relacionadas con el control de personal, reportes y documentación interna.",
        url: "",
        icon: Icons.work,
        color: Colors.blue,
        technologies: const [
          "Laravel", "PHP", "Flutter", "Postman", "MariaDB", "GitHub", "Teams",
        ],
        period: '2023 - 2024',
      ),
    ];
  }

  // ============================================================
  // LOGOS
  // ============================================================
  Widget _buildLogo() {
    return Image.asset(
      "assets/images/footer_logo.png",
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
    );
  }

  Widget _buildLogo2() {
    return Image.asset(
      "assets/images/footer_logo2.png",
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
    );
  }

  Widget _buildLogo3() {
    return Image.asset(
      "assets/images/american.png",
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
    );
  }

  Widget _buildLogo4() {
    return Image.asset(
      "assets/images/cfe_logo.png",
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
    );
  }
}