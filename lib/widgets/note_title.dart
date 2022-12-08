import 'package:flutter/material.dart';

Widget noteTitle(ctx, title, color) {
  return Text(
    title,
    style: Theme.of(ctx).textTheme.titleLarge!.copyWith(color: color),
  );
}
