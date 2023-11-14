// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pill_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PillSearchModel _$PillSearchModelFromJson(Map<String, dynamic> json) =>
    PillSearchModel(
      labelForms: json['labelForms'] as String,
      labelShapes: json['labelShapes'] as String,
      labelColor1: json['labelColor1'] as String,
      labelColor2: json['labelColor2'] as String,
      labelLineFront: json['labelLineFront'] as String? ?? "",
      labelLineBack: json['labelLineBack'] as String? ?? "",
      labelPrintFront: json['labelPrintFront'] as String? ?? "",
      labelPrintBack: json['labelPrintBack'] as String? ?? "",
    );

Map<String, dynamic> _$PillSearchModelToJson(PillSearchModel instance) =>
    <String, dynamic>{
      'labelForms': instance.labelForms,
      'labelShapes': instance.labelShapes,
      'labelColor1': instance.labelColor1,
      'labelColor2': instance.labelColor2,
      'labelLineFront': instance.labelLineFront,
      'labelLineBack': instance.labelLineBack,
      'labelPrintFront': instance.labelPrintFront,
      'labelPrintBack': instance.labelPrintBack,
    };
