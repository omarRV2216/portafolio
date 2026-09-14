import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  final bool isDarkMode;

  const AboutSection({
    super.key,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sobre mí",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "Soy desarrollador fullstack con experiencia en desarrollar y "
                "crear aplicaciones multiplataforma. Me encanta resolver problemas complejos y "
                "aprender nuevas tecnologías.",
            style: TextStyle(
              fontSize: 18,
              color: isDarkMode ? Colors.white : Colors.black,
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
        color: isDarkMode ? Colors.grey[850] : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
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
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
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
          colors: isDarkMode
              ? [Colors.blue.withOpacity(0.2), Colors.purple.withOpacity(0.2)]
              : [Colors.blue.withOpacity(0.1), Colors.purple.withOpacity(0.1)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDarkMode
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
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}