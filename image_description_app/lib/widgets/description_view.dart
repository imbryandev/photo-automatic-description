import 'package:flutter/material.dart';

class DescriptionView extends StatelessWidget {
  const DescriptionView({super.key, this.description});
  final String? description;
  @override
  Widget build(BuildContext context) {  
    if (description == null) {
      return const SizedBox.shrink();
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: description == null
      ? const SizedBox.shrink()
      : AnimatedContainer(
        key: ValueKey(description),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const Icon(Icons.auto_awesome, color: Colors.indigo, size: 36),
            const SizedBox(height: 10),
            const Text(
              'Descripción generada por IA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}