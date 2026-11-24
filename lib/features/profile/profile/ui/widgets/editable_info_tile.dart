import 'package:flutter/material.dart';
import '../../../widgets/info_tile.dart';
import '../../data/models/user_model.dart';
import '../../logic/profile_field.dart';
import 'edit_field_sheet.dart';

/// InfoTile that opens the edit sheet for [field] when tapped.
class EditableInfoTile extends StatelessWidget {
  const EditableInfoTile({
    super.key,
    required this.icon,
    required this.field,
    required this.user,
    this.label,
  });

  final IconData icon;
  final ProfileField field;
  final UserModel user;

  /// Use it when the screen wants a different title than [ProfileField.label].
  final String? label;

  @override
  Widget build(BuildContext context) {
    final value = field.read(user);

    return InfoTile(
      icon: icon,
      label: label ?? field.label,
      value: value,
      showChevron: true,
      onTap: () => showEditFieldSheet(context, field: field, initial: value),
    );
  }
}
