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
      height: MediaQuery.of(context).size.height,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
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
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: isDarkMode,
                          logo: _buildLogo2(),
                          company: "Cybac TI",
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
                          isDarkMode: isDarkMode,
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: isDarkMode,
                          logo: _buildLogo(),
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
                            "laravel 10",
                            "Php",
                            "Livewire",
                            "Boostrap",
                            "DoomPDF",
                          ],
                          period: '2025',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: ExperienceCard(
                          isDarkMode: isDarkMode,
                          logo: _buildLogo(),
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

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
      "images/logo.png",
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: const Icon(
            Icons.image_not_supported,
            color: Colors.grey,
            size: 50,
          ),
        );
      },
    );
  }
}