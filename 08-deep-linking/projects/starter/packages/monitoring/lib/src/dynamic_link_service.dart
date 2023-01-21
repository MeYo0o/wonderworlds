import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';

export 'package:firebase_dynamic_links/firebase_dynamic_links.dart'
    show SocialMetaTagParameters;

typedef OnNewDynamicLinkPath = void Function(String newDynamicLinkPath);

/// Wrapper around [FirebaseDynamicLinks].
class DynamicLinkService {
  static const _domainUriPrefix = 'https://wonderwordsmeyo.page.link';
  static const _iOSBundleId = 'com.raywenderlich.wonderWords';
  static const _androidPackageName = 'com.raywenderlich.wonder_words';

  DynamicLinkService({
    @visibleForTesting FirebaseDynamicLinks? dynamicLinks,
  }) : _dynamicLinks = dynamicLinks ?? FirebaseDynamicLinks.instance;

  final FirebaseDynamicLinks _dynamicLinks;

  Future<String> generateDynamicLinkUrl({
    required String path,
    SocialMetaTagParameters? socialMetaTagParameters,
  }) async {
    final parameters = DynamicLinkParameters(
      link: Uri.parse('$_domainUriPrefix$path'),
      uriPrefix: _domainUriPrefix,
      androidParameters: const AndroidParameters(
        packageName: _androidPackageName,
      ),
      iosParameters: const IOSParameters(
        bundleId: _iOSBundleId,
      ),
      socialMetaTagParameters: socialMetaTagParameters,
    );

    final shortLink = await _dynamicLinks.buildShortLink(parameters);
    return shortLink.shortUrl.toString();
  }

  Future<String?> getInitialDynamicLinkPath() async {
    final data = await _dynamicLinks.getInitialLink();
    final link = data?.link;
    return link?.path;
  }

  Stream<String> get onNewDynamicLinkPath {
    return _dynamicLinks.onLink.map(
      (event) {
        final link = event.link;
        final path = link.path;
        return path;
      },
    );
  }
}
