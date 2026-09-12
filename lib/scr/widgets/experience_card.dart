import 'package:flutter/material.dart';
import 'package:portafolio/scr/utils/url_launcher_helper.dart';

class ExperienceCard extends StatelessWidget {
  final bool isDarkMode;
  final String company;
  final String position;
  final String period;
  final String description;
  final String url;
  final IconData icon;
  final Color color;
  final List<String> technologies;
  final Widget? logo;

  const ExperienceCard({
    super.key,
    required this.isDarkMode,
    required this.company,
    required this.position,
    required this.period,
    required this.description,
    required this.url,
    required this.icon,
    required this.color,
    required this.technologies,
    this.logo,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasUrl = url.isNotEmpty;

    Widget cardContent = Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDarkMode
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
          if (logo != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: logo,
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
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
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
                              color: isDarkMode
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
                      color: isDarkMode ? Colors.grey[500] : Colors.grey[400],
                      size: 14,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      period,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode
                            ? Colors.grey[400]
                            : Colors.grey[500],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: technologies
                      .map((tech) => _buildTechChip(tech, color))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    if (hasUrl) {
      return InkWell(
        onTap: () => launchUrl(url),
        borderRadius: BorderRadius.circular(16),
        child: cardContent,
      );
    }

    return cardContent;
  }

  Widget _buildTechChip(String tech, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isDarkMode ? color.withOpacity(0.2) : color.withOpacity(0.08),
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
          color: isDarkMode ? Colors.white : color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}