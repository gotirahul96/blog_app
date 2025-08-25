String calculateReadTime(String text, {int wordsPerMinute = 225}) {
  if (text.trim().isEmpty || wordsPerMinute <= 0) return "0 min read";

  final wordMatches = RegExp(r"[A-Za-z0-9\u00C0-\u017F']+").allMatches(text);
  final wordCount = wordMatches.length;

  final minutes = wordCount / wordsPerMinute;
  final totalSeconds = (minutes * 60).round();

  if (totalSeconds < 60) {
    final secs = (totalSeconds / 5).clamp(1, 11).round() * 5; // round to 5s
    return "$secs sec read";
  } else {
    final mins = (totalSeconds / 60).ceil(); // round up minutes
    return "$mins min read";
  }
}
