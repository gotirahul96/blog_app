
import 'dart:math';
import 'dart:ui' show Color;

Color getRandomColor(List<Color> colors) {
    final random = Random();
    return colors[random.nextInt(colors.length)];
  }