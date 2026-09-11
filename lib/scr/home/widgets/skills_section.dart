import 'package:flutter/material.dart';

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
                    color: isDarkMode ? Colors.white : Colors.black,
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
        color: isDarkMode
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
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}