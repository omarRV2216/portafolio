import 'package:flutter/material.dart';
import 'package:portafolio/scr/widgets/skill.dart';

class SkillsSection extends StatelessWidget {
  final bool isDarkMode;

  const SkillsSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Mis Habilidades",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
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
                          skills: const [
                            Skill(
                              name: "Flutter",
                              iconFile: "icon_flutter.png",
                              color: Color(0xFF02569B),
                            ),
                            Skill(
                              name: "JSON",
                              iconFile: "icon_json.png",
                              color: Color(0xFFF7DF1E),
                            ),
                            Skill(
                              name: "Web Service",
                              iconFile: "icon_webservice.png",
                              color: Color(0xFF6C63FF),
                            ),
                            Skill(
                              name: "MVC",
                              iconFile: "webservice.png",
                              color: Color(0xFF42BA5F),
                            ),
                            Skill(
                              name: "DIO",
                              iconFile: "webservice.png",
                              color: Color(0xFFDCA925),
                            ),
                          ],
                          icon: Icons.phone_android,
                          color: Colors.blue,
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: _buildSkillCategory(
                          title: "Desarrollo Web",
                          skills: const [
                            Skill(
                              name: "PHP",
                              iconFile: "icon_php.png",
                              color: Color(0xFF777BB4),
                            ),
                            Skill(
                              name: "Laravel",
                              iconFile: "icon_laravle.png",
                              color: Color(0xFFFB503B),
                            ),
                            Skill(
                              name: "WebService",
                              iconFile: "icon_webservice.png",
                              color: Color(0xFFFF2D20),
                            ),
                            Skill(
                              name: "Livewire",
                              iconFile: "livewire.png",
                              color: Color(0xFFFB503B),
                            ),
                            Skill(
                              name: "MVC",
                              iconFile: "webservice.png",
                              color: Color(0xFF42BA5F),
                            ),
                          ],
                          icon: Icons.phone_android,
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
                          skills: const [
                            Skill(
                              name: "React",
                              iconFile: "icon_react.png",
                              color: Color(0xFF61DAFB),
                            ),
                            Skill(
                              name: "JavaScript",
                              iconFile: "icon_js.png",
                              color: Color(0xFFF7DF1E),
                            ),
                            Skill(
                              name: "Tailwind CSS",
                              iconFile: "icon_tailwind.png",
                              color: Color(0xFF38BDF8),
                            ),
                            Skill(
                              name: "Bootstrap",
                              iconFile: "icons_boostrap.png",
                              color: Color(0xFF7952B3),
                            ),
                          ],
                          icon: Icons.color_lens,
                          color: Colors.orange,
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: _buildSkillCategory(
                          title: "Base de Datos",
                          skills: const [
                            Skill(
                              name: "MariaDB",
                              iconFile: "icon_mariandb.png",
                              color: Color(0xFF003545),
                            ),
                            Skill(
                              name: "MySql",
                              iconFile: "icon_mysql.png",
                              color: Color(0xFF382923),
                            ),
                          ],
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
                          skills: const [
                            Skill(
                              name: "Postman",
                              iconFile: "icon_postman.png",
                              color: Color(0xFFFF6C37),
                            ),
                            Skill(
                              name: "GitHub",
                              iconFile: "icon_github.png",
                              color: Color(0xFF181717),
                            ),
                            Skill(
                              name: "GitLab",
                              iconFile: "icon_gitlab.png",
                              color: Color(0xFFFC6D26),
                            ),
                          ],
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

  // ============================================================
  // TARJETA DE CATEGORÍA
  // ============================================================
  Widget _buildSkillCategory({
    required String title,
    required List<Skill> skills,

    // Puede recibir un IconData
    IconData? icon,

    // O puede recibir un PNG
    String? iconFile,

    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
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
          // === Header: [logo] Título ===
          Row(
            children: [
              _buildTechImage(
                iconFile: iconFile,
                icon: icon,
                size: 28,
                fallbackIcon: Icons.code,
                color: color,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // === Chips: [logo png] Nombre ===
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills.map(_buildSkillChip).toList(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CHIP: [logo png] + Nombre
  // ============================================================
  Widget _buildSkillChip(Skill skill) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: isDarkMode
            ? skill.color.withOpacity(0.18)
            : skill.color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: skill.color.withOpacity(0.35),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTechImage(
            iconFile: skill.iconFile,
            size: 18,
            fallbackIcon: Icons.code,
            color: skill.color,
          ),

          const SizedBox(width: 6),

          Text(
            skill.name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HELPER: PNG O ICONO DE FLUTTER
  // ============================================================
  Widget _buildTechImage({
    String? iconFile,
    IconData? icon,
    double size = 20,
    IconData fallbackIcon = Icons.image_not_supported,
    Color? color,
  }) {
    if (icon != null) {
      return Icon(
        icon,
        size: size,
        color: color ?? (isDarkMode ? Colors.white : Colors.black87),
      );
    }

    if (iconFile != null && iconFile.isNotEmpty) {
      return Image.asset(
        "assets/icons/$iconFile",
        width: size,
        height: size,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.high,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            fallbackIcon,
            size: size,
            color: color ??
                (isDarkMode ? Colors.grey[500] : Colors.grey[400]),
          );
        },
      );
    }

    // Si no hay ni PNG ni icono
    return Icon(
      fallbackIcon,
      size: size,
      color: color ??
          (isDarkMode ? Colors.grey[500] : Colors.grey[400]),
    );
  }
}