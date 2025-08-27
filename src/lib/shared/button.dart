import 'package:flutter/material.dart';
import 'package:my_app/shared/app_colors.dart';

enum ButtonVariant { primary, secondary, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = ButtonVariant.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: _getButtonStyle(),
        child: Row(
          mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: 8),
            ] else if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(text),
          ],
        ),
      ),
    );
  }

  ButtonStyle _getButtonStyle() {
    switch (variant) {
      case ButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: kcPrimaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      case ButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: kcSecondaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
      case ButtonVariant.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: kcPrimaryColor,
          side: const BorderSide(color: kcPrimaryColor, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
    }
  }
}
