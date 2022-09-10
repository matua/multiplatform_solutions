// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Person _$$_PersonFromJson(Map<String, dynamic> json) => _$_Person(
      id: (json['id'] as num).toDouble(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$$_PersonToJson(_$_Person instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'imageUrl': instance.imageUrl,
    };
