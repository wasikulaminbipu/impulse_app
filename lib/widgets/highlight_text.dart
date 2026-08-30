import 'package:flutter/material.dart';

/// Renders [text] with matching search tokens highlighted using [highlightStyle] or primary colors.
class HighlightText extends StatelessWidget {
  const HighlightText({
    super.key,
    required this.text,
    required this.query,
    this.style,
    this.highlightStyle,
    this.maxLines,
    this.overflow = TextOverflow.clip,
  });

  final String? text;
  final String? query;
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final int? maxLines;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultTextStyle = DefaultTextStyle.of(context).style;
    final effectiveStyle = defaultTextStyle.merge(
      style ?? theme.textTheme.bodyMedium,
    );

    final defaultHighlightStyle =
        highlightStyle ??
        effectiveStyle.copyWith(
          backgroundColor: theme.colorScheme.primaryContainer.withValues(
            alpha: 0.7,
          ),
          color: theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        );

    final rawText = text ?? '';
    final trimmedQuery = (query ?? '').trim();
    if (trimmedQuery.isEmpty || rawText.isEmpty) {
      return Text(
        rawText,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final queryTokens = trimmedQuery
        .toLowerCase()
        .split(RegExp(r'\s+'))
        .where((t) => t.isNotEmpty)
        .toList();

    if (queryTokens.isEmpty) {
      return Text(
        rawText,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final patternString = queryTokens.map(RegExp.escape).join('|');
    if (patternString.isEmpty) {
      return Text(
        rawText,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
      );
    }

    final pattern = RegExp(patternString, caseSensitive: false);

    final spans = <TextSpan>[];
    int start = 0;

    for (final match in pattern.allMatches(rawText)) {
      if (match.start > start) {
        spans.add(
          TextSpan(
            text: rawText.substring(start, match.start),
            style: effectiveStyle,
          ),
        );
      }
      spans.add(
        TextSpan(
          text: rawText.substring(match.start, match.end),
          style: defaultHighlightStyle,
        ),
      );
      start = match.end;
    }

    if (start < rawText.length) {
      spans.add(
        TextSpan(text: rawText.substring(start), style: effectiveStyle),
      );
    }

    return Text.rich(
      TextSpan(style: effectiveStyle, children: spans),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
