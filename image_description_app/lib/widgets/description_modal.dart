import 'package:flutter/material.dart';

class DescriptionModal extends StatelessWidget {
  final String? description;
  final VoidCallback? onClose;

  const DescriptionModal({
    super.key,
    this.description,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    if (description == null) {
      return const SizedBox.shrink();
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: AnimatedContainer(
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
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Botón de cerrar en la esquina superior derecha
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.grey),
                onPressed: onClose,
                tooltip: 'Cerrar',
              ),
            ),

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
