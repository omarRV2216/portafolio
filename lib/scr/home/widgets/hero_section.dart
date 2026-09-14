import 'package:flutter/material.dart';

class HeroSection extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onSeeProjects;

  const HeroSection({
    super.key,
    required this.isDarkMode,
    required this.onSeeProjects,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _jumpAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true); // sube y baja infinitamente

    // Curva "easeInOut" para que el salto sea natural (frena arriba y abajo)
    _jumpAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = widget.isDarkMode;

    return Container(
      height: MediaQuery.of(context).size.height,
      color: isDarkMode ? Colors.grey[900] : Colors.white,
      padding: const EdgeInsets.all(9),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // === AVATAR CON ANIMACIÓN DE SALTO ===
          AnimatedBuilder(
            animation: _jumpAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(0, _jumpAnimation.value),
                child: child,
              );
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDarkMode
                      ? [Colors.grey[800]!, Colors.grey[600]!]
                      : [Colors.blue[300]!, Colors.blue[100]!],
                ),
              ),
              child: ClipOval(
                child: Center(
                  child: Image.asset(
                    "assets/images/fluticon.png",
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.red,
                        child: const Center(
                          child: Icon(Icons.image_not_supported),
                        ),
                      );
                    },
                  ),
                ),
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
                  color: isDarkMode ? Colors.white : Colors.black,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Soy Omar Aldair",
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w700,
                  color: isDarkMode ? Colors.white : Colors.black,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 12),
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isDarkMode
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
                onPressed: widget.onSeeProjects,
                style: ElevatedButton.styleFrom(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                  backgroundColor: isDarkMode ? Colors.white : Colors.black,
                  foregroundColor: isDarkMode ? Colors.black : Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: isDarkMode
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
                      color: isDarkMode ? Colors.black : Colors.white,
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
}