import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _ExperienceCard extends StatefulWidget {
  final Widget logo;
  final String company;
  final String position;
  final String period;
  final String description;
  final String url;
  final IconData icon;
  final Color color;
  final List<String> technologies;

  const _ExperienceCard({
    required this.logo,
    required this.company,
    required this.position,
    required this.period,
    required this.description,
    required this.url,
    required this.icon,
    required this.color,
    required this.technologies,
  });

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.logo,
            const SizedBox(height: 16),

            // Empresa + periodo
            Row(
              children: [
                Icon(widget.icon, color: widget.color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.company,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  widget.period,
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 4),

            // Puesto
            Text(
              widget.position,
              style: TextStyle(
                fontSize: 14,
                color: widget.color,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            // Descripción con expandir/colapsar
            AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: _expanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Text(
                widget.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
              secondChild: Text(
                widget.description,
                style: const TextStyle(fontSize: 14, height: 1.5),
              ),
            ),

            // Botón Leer más / Leer menos
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => setState(() => _expanded = !_expanded),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _expanded ? "Leer menos" : "Leer más",
                      style: TextStyle(
                        color: widget.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: widget.color,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            // Tecnologías
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.technologies
                  .map((tech) => Chip(
                label: Text(tech, style: const TextStyle(fontSize: 12)),
                backgroundColor: widget.color.withOpacity(0.1),
                side: BorderSide.none,
                padding: EdgeInsets.zero,
              ))
                  .toList(),
            ),

            const SizedBox(height: 12),

            // URL
            InkWell(
              onTap: () async {
                final uri = Uri.parse(widget.url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Text(
                widget.url,
                style: TextStyle(
                  color: widget.color,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}