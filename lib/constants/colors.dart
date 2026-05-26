import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF905FFF);
  static const Color primaryLight = Color(0xFFF3E8FF);
  static const Color primaryDark = Color(0xFF7C3AED);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Category Colors
  static const Color movieBg = Color(0xFFF3E8FF);
  static const Color movieText = Color(0xFF905FFF);

  static const Color exhibitionBg = Color(0xFFF3E8FF);
  static const Color exhibitionText = Color(0xFF905FFF);

  static const Color tastingBg = Color(0xFFFEF3C7);
  static const Color tastingText = Color(0xFFB45309);

  static const Color cyclingBg = Color(0xFFD1FAE5);
  static const Color cyclingText = Color(0xFF059669);

  static const Color outdoorBg = Color(0xFFE0F2FE);
  static const Color outdoorText = Color(0xFF0369A1);

  static const Color sportsBg = Color(0xFFF3E8FF);
  static const Color sportsText = Color(0xFF905FFF);

  static const Color musicBg = Color(0xFFF3E8FF);
  static const Color musicText = Color(0xFF905FFF);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF905FFF), Color(0xFFA855F7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // New vibrant gradients
  static const LinearGradient movieGradient = LinearGradient(
    colors: [Color(0xFFFF6B6B), Color(0xFFFF8E72)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient exhibitionGradient = LinearGradient(
    colors: [Color(0xFF4ECDC4), Color(0xFF44A08D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tastingGradient = LinearGradient(
    colors: [Color(0xFFFFD93D), Color(0xFFFFA500)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cyclingGradient = LinearGradient(
    colors: [Color(0xFF6BCB77), Color(0xFF4D96FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient outdoorGradient = LinearGradient(
    colors: [Color(0xFF00D4FF), Color(0xFF0099FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
