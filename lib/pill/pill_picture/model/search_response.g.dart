// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      imgLink: json['imgLink'] as String,
      labelForms: json['labelForms'] as String,
      labelShapes: json['labelShapes'] as String,
      labelColor1: json['labelColor1'] as String,
      labelColor2: json['labelColor2'] as String,
      labelLineFront: json['labelLineFront'] as String? ?? "",
      labelLineBack: json['labelLineBack'] as String? ?? "",
      labelPrintFront: json['labelPrintFront'] as String? ?? "",
      labelPrintBack: json['labelPrintBack'] as String? ?? "",
    );

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgLink': instance.imgLink,
      'labelForms': instance.labelForms,
      'labelShapes': instance.labelShapes,
      'labelColor1': instance.labelColor1,
      'labelColor2': instance.labelColor2,
      'labelLineFront': instance.labelLineFront,
      'labelLineBack': instance.labelLineBack,
      'labelPrintFront': instance.labelPrintFront,
      'labelPrintBack': instance.labelPrintBack,
    };
