import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

class PatchServer {
  String id;
  String name;
  String description;
  String image;
  List<PatchServerUrls> urls;
  String infoUrl;
  String? controllerUrl;

  PatchServer(
      {required this.id,
      required this.name,
      required this.description,
      required this.image,
      required this.urls,
      required this.infoUrl,
      required this.controllerUrl
      });

  factory PatchServer.fromJson(String url, Map<String, dynamic> json) {
    return PatchServer(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      urls: (json['urls'] as List<dynamic>)
          .map((e) => PatchServerUrls.fromJson(e))
          .toList(),
      infoUrl: url,
      controllerUrl: json['controller'],
    );
  }

  Future<PatchServerUrls> getVersionUrl() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return urls.firstWhere(
        (element) => element.versions.contains(packageInfo.version),
        orElse: () => urls.first);
  }
}

class PatchServerUrls {
  List<dynamic> versions;
  String apiEndpoint;
  String assetsEndpoint;

  PatchServerUrls(
      {required this.versions,
      required this.apiEndpoint,
      required this.assetsEndpoint});

  factory PatchServerUrls.fromJson(Map<String, dynamic> json) {
    return PatchServerUrls(
      versions: json['versions'],
      apiEndpoint: json['api'],
      assetsEndpoint: json['assets'],
    );
  }
}
