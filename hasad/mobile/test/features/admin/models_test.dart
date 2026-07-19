import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/admin/domain/role.dart';
import 'package:mobile/features/location/domain/directorate.dart';
import 'package:mobile/features/location/domain/governorate.dart';

void main() {
  group('User Management Models', () {
    test('Role.fromJson parses correctly', () {
      final json = {'id': 'r1', 'name': 'SuperAdmin', 'scopeType': 'Global'};
      final role = Role.fromJson(json);
      expect(role.id, 'r1');
      expect(role.name, 'SuperAdmin');
      expect(role.scopeType, 'Global');
    });

    test('Governorate.fromJson parses correctly', () {
      final json = {'id': 'g1', 'nameAr': 'غزة', 'nameEn': 'Gaza'};
      final gov = Governorate.fromJson(json);
      expect(gov.id, 'g1');
      expect(gov.nameAr, 'غزة');
      expect(gov.nameEn, 'Gaza');
    });

    test('Directorate.fromJson parses correctly', () {
      final json = {
        'id': 'd1',
        'nameAr': 'شمال غزة',
        'nameEn': 'North Gaza',
        'governorateId': 'g1',
      };
      final dir = Directorate.fromJson(json);
      expect(dir.id, 'd1');
      expect(dir.nameAr, 'شمال غزة');
      expect(dir.nameEn, 'North Gaza');
      expect(dir.governorateId, 'g1');
    });
  });
}
