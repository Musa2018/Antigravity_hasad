import 'package:freezed_annotation/freezed_annotation.dart';

enum Gender {
  @JsonValue(0)
  unspecified,
  @JsonValue(1)
  male,
  @JsonValue(2)
  female,
}
