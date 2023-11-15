// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseModel _$SearchResponseModelFromJson(Map<String, dynamic> json) =>
    SearchResponseModel(
      id: json['id'] as int,
      name: json['name'] as String,
      imgLink: json['img_link'] as String,
      labelForms: json['label_forms'] as String,
      labelShapes: json['label_shapes'] as String,
      labelColor1: json['label_color1'] as String,
      labelColor2: json['label_color2'] as String,
      labelLineFront: json['label_line_front'] as String? ?? '',
      labelLineBack: json['label_line_back'] as String? ?? '',
      labelPrintFront: json['label_print_front'] as String? ?? '',
      labelPrintBack: json['label_print_back'] as String? ?? '',
    );

Map<String, dynamic> _$SearchResponseModelToJson(
        SearchResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'img_link': instance.imgLink,
      'label_forms': instance.labelForms,
      'label_shapes': instance.labelShapes,
      'label_color1': instance.labelColor1,
      'label_color2': instance.labelColor2,
      'label_line_front': instance.labelLineFront,
      'label_line_back': instance.labelLineBack,
      'label_print_front': instance.labelPrintFront,
      'label_print_back': instance.labelPrintBack,
    };
