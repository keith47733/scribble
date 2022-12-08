import 'package:flutter/material.dart';

Widget noteDate(ctx, date, color) {
  return Text(
    date,
    style: Theme.of(ctx).textTheme.titleSmall!.copyWith(color: color),
  );
}
