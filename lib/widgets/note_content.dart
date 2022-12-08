import 'package:flutter/material.dart';

Widget noteContent(ctx, content, color) {
  return Text(
    content,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: Theme.of(ctx).textTheme.titleMedium!.copyWith(color: color),
  );
}
