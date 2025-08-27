import 'package:flutter/material.dart';
import 'package:my_app/shared/app_colors.dart';

enum CardVariant {
  elevated,
  outlined,
  filled,
}

class CustomCard extends StatelessWidget {
  final Widget child;
  final CardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const CustomCard({
    super.key,
    required this.child,
    this.variant = CardVariant.elevated,
    this.onTap,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: _getDecoration(),
            child: child,
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (variant) {
      case CardVariant.elevated:
        return BoxDecoration(
          color: kcSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        );

      case CardVariant.outlined:
        return BoxDecoration(
          color: kcSurfaceColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: kcSecondaryTextColor.withOpacity(0.3),
          ),
        );

      case CardVariant.filled:
        return BoxDecoration(
          color: kcPrimaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        );
    }
  }
}
