import 'package:flutter/material.dart';
import 'package:reflectable/mirrors.dart';
import 'package:reflectable/reflectable.dart';
import 'reflector.dart';

class DataTableHelper {
  static List<String> convertModelPropertiesToStrings(dynamic model) {
    List<String> propertyValues = [];

    var type = model.runtimeType;

    type.toString().split(' ').last.split('.').forEach((property) {
      var value = model.toMap()[property];
      propertyValues.add(value.toString());
    });

    return propertyValues;
  }

  static List<DataColumn> buildColumns<T>(
      {bool forPrint = false, List<String> blacklist = const []}) {
    List<DataColumn> columns = [];

    List<String> properties = fetchProperties<T>(blacklist: blacklist);

    for (var property in properties) {
      if (forPrint) {
        formatProperty(property, columns);
      } else {
        columns.add(DataColumn(label: Text(property)));
      }
    }
    print(columns);
    return columns;
  }

  static void formatProperty(String property, List<DataColumn> columns) {
    String formattedProperty = property.replaceAllMapped(
      RegExp(r'(?<=[a-z])(?=[A-Z])'),
      (match) => ' ${match.group(0)}',
    );
    formattedProperty =
        formattedProperty[0].toUpperCase() + formattedProperty.substring(1);
    columns.add(DataColumn(
      label: Text(formattedProperty),
    ));
  }

  static List<String> fetchProperties<T>({List<String> blacklist = const []}) {
    final classMirror = reflector.reflectType(T);
    final classMirrorDecl = classMirror as ClassMirror;
    final properties = classMirrorDecl.declarations.keys.where((property) {
      final lowerCaseProperty = property.toLowerCase();
      return !lowerCaseProperty.contains('id') &&
          !lowerCaseProperty
              .contains(classMirrorDecl.simpleName.toLowerCase()) &&
          !blacklist.contains(lowerCaseProperty);
    }).toList();
    return properties;
  }

  static String lowercaseFirstLetter(String string) {
    if (string.isEmpty) {
      return string;
    } else {
      return string[0].toLowerCase() + string.substring(1);
    }
  }

  static List<DataRow> buildRows<T>(List<T?>? data,
      {Function(int)? onPress, List<String> blacklist = const []}) {
    final classMirror = reflector.reflectType(T) as ClassMirror;
    List<DataRow> rows = [];

    if (data == null || data.isEmpty) return rows;
    final columns = buildColumns<T>(forPrint: false, blacklist: blacklist);
    for (var item in data) {
      if (item == null) continue;
      final itemValue = reflector.reflect(item);
      List<DataCell> cells = [];
      for (var column in columns) {
        final text = column.label as Text;
        var finalValue =
            itemValue.invokeGetter(lowercaseFirstLetter(text.data ?? ''));
        print(finalValue);
        if (finalValue != null) {
          final stringValue = finalValue is Enum
              ? finalValue.toString().split(".").last
              : finalValue is bool
                  ? finalValue
                      ? "Yes"
                      : "No"
                  : finalValue.toString();

          cells.add(DataCell(Text(stringValue)));
        } else {
          cells.add(const DataCell(Text("")));
        }
      }

      rows.add(DataRow(
          cells: cells,
          onLongPress: onPress != null
              ? () => onPress(itemValue.invokeGetter('id') as int)
              : null));
    }

    return rows;
  }
}

final blackList = [
  "password",
  "passwordconfirm",
  "image",
  "==",
  "fullname",
  "searchterm"
];
