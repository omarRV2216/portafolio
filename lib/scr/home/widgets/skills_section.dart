import 'package:flutter/material.dart';
import 'package:portafolio/scr/widgets/skill.dart';

class SkillsSection extends StatefulWidget {
  final bool isDarkMode;

  const SkillsSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  int _selectedTab = 0;

  // ============================================================
  // CATEGORÍAS
  // ============================================================
  late final List<Map<String, dynamic>> _categories = [
    {
      "title": "Frontend",
      "icon": Icons.color_lens,
      "color": Colors.orange,
      "skills": const [
        Skill(name: "React", iconFile: "icon_react.png", color: Color(0xFF61DAFB)),
        Skill(name: "JavaScript", iconFile: "icon_js.png", color: Color(0xFFF7DF1E)),
        Skill(name: "Livewire", iconFile: "livewire.png", color: Color(0xFFFB503B)),
        Skill(name: "Flutter", iconFile: "icon_flutter.png", color: Color(0xFF0B55F1)),
        Skill(name: "Laravel", iconFile: "icon_laravle.png", color: Color(0xFFFB503B)),
        Skill(name: "PHP", iconFile: "icon_php.png", color: Color(0xFF777BB4)),
        Skill(name: "Tailwind CSS", iconFile: "icon_tailwind.png", color: Color(0xFF38BDF8)),
        Skill(name: "Bootstrap", iconFile: "icons_boostrap.png", color: Color(0xFF7952B3)),
      ],
    },
    {
      "title": "Backend",
      "icon": Icons.web,
      "color": Colors.purple,
      "skills": const [
        Skill(name: "PHP", iconFile: "icon_php.png", color: Color(0xFF777BB4)),
        Skill(name: "Laravel", iconFile: "icon_laravle.png", color: Color(0xFFFB503B)),
        Skill(name: "JavaScript", iconFile: "icon_js.png", color: Color(0xFFF7DF1E)),
      ],
    },
  ];

  // ============================================================
  // LISTA PLANA PARA LA PESTAÑA "TODAS"
  // ============================================================
  late final List<Skill> _allSkills = const [
    Skill(name: "JavaScript", iconFile: "icon_js.png", color: Color(0xFFF7DF1E)),
    Skill(name: "PHP", iconFile: "icon_php.png", color: Color(0xFF777BB4)),
    Skill(name: "GitHub", iconFile: "icon_github.png", color: Color(0xFF181717)),
    Skill(name: "GitLab", iconFile: "icon_gitlab.png", color: Color(0xFFFC6D26)),
    Skill(name: "Postman", iconFile: "icon_postman.png", color: Color(0xFFFF6C37)),
    Skill(name: "MySql", iconFile: "icon_mysql.png", color: Color(0xFF4479A1)),
    Skill(name: "MariaDB", iconFile: "icon_mariandb.png", color: Color(0xFF4479A1)),
    Skill(name: "Flutter", iconFile: "icon_flutter.png", color: Color(0xFF1572B6)),
    Skill(name: "React", iconFile: "icon_react.png", color: Color(0xFF61DAFB)),
    Skill(name: "Bootstrap", iconFile: "icons_boostrap.png", color: Color(0xFF7952B3)),
    Skill(name: "Laravel", iconFile: "icon_laravle.png", color: Color(0xFFFB503B)),
    Skill(name: "Tailwind", iconFile: "icon_tailwind.png", color: Color(0xFF38BDF8)),
    Skill(name: "WebService", iconFile: "icon_webservice.png", color: Color(0xFF000000)),
    Skill(name: "Español", iconFile: "", color: Color(0xFF6C63FF)),
    Skill(name: "Inglés", iconFile: "", color: Color(0xFF6C63FF)),
  ];


  final List<int?> _tabIndices = [null, 0, 1];
  final List<String> _tabLabels = ["Todas", "Frontend", "Backend"];

  bool get isDarkMode => widget.isDarkMode;

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
          Text(
            "Mis Habilidades",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),

          const SizedBox(height: 20),

          _buildTabBar(),

          const SizedBox(height: 30),

          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[850] : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          ),
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 4,
          children: List.generate(_tabLabels.length, (index) {
            final bool selected = _selectedTab == index;
            return GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: selected
                      ? (isDarkMode ? Colors.blueAccent : Colors.blue)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  _tabLabels[index],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    color: selected
                        ? Colors.white
                        : (isDarkMode ? Colors.white70 : Colors.black87),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }


  Widget _buildContent() {
    final int? index = _tabIndices[_selectedTab];

    if (index == null) {
      return _buildSkillsGrid(_allSkills);
    }

    final cat = _categories[index];
    return _buildSkillsGrid(cat["skills"] as List<Skill>);
  }


  Widget _buildSkillsGrid(List<Skill> skills) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              int columns;
              if (constraints.maxWidth >= 900) {
                columns = 4;
              } else if (constraints.maxWidth >= 650) {
                columns = 3;
              } else if (constraints.maxWidth >= 420) {
                columns = 2;
              } else {
                columns = 1;
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: skills.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columns,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 20,
                  childAspectRatio: 3.6,
                ),
                itemBuilder: (context, index) {
                  return _buildSkillGridItem(skills[index]);
                },
              );
            },
          ),
        ),
      ),
    );
  }


  Widget _buildSkillGridItem(Skill skill) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildTechImage(
          iconFile: skill.iconFile.isNotEmpty ? skill.iconFile : null,
          icon: skill.iconFile.isEmpty ? Icons.language : null,
          size: 32,
          fallbackIcon: Icons.code,
          color: isDarkMode ? Colors.white : Colors.black87,
        ),

        const SizedBox(width: 14),

        Expanded(
          child: Text(
            skill.name,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

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
            color: color ?? (isDarkMode ? Colors.grey[500] : Colors.grey[400]),
          );
        },
      );
    }

    return Icon(
      fallbackIcon,
      size: size,
      color: color ?? (isDarkMode ? Colors.grey[500] : Colors.grey[400]),
    );
  }
}