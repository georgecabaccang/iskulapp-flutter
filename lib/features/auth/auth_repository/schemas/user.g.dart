// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthenticatedUserImpl _$$AuthenticatedUserImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthenticatedUserImpl(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );

Map<String, dynamic> _$$AuthenticatedUserImplToJson(
        _$AuthenticatedUserImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
    };
