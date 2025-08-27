import 'package:flutter/material.dart';
import 'package:my_app/shared/app_colors.dart';

// Heading Styles
TextStyle heading1Style(BuildContext context) => const TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: kcPrimaryTextColor,
    );

TextStyle heading2Style(BuildContext context) => const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: kcPrimaryTextColor,
    );

TextStyle heading3Style(BuildContext context) => const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: kcPrimaryTextColor,
    );

// Body Styles
TextStyle bodyStyle(BuildContext context) => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: kcPrimaryTextColor,
    );

TextStyle bodySmallStyle(BuildContext context) => const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: kcSecondaryTextColor,
    );

// Button Styles
TextStyle buttonTextStyle(BuildContext context) => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );

// Special Styles
TextStyle linkStyle(BuildContext context) => const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: kcPrimaryColor,
      decoration: TextDecoration.underline,
    );

TextStyle errorStyle(BuildContext context) => const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kcErrorColor,
    );

TextStyle successStyle(BuildContext context) => const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: kcSuccessColor,
    );

// Legacy aliases
TextStyle subtitleStyle(BuildContext context) => bodySmallStyle(context);
