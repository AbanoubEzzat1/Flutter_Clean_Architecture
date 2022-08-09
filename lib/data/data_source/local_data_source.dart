// ignore_for_file: constant_identifier_names, prefer_collection_literals

import 'package:flutter_clean_arch_revision2/data/network/error_handler.dart';
import 'package:flutter_clean_arch_revision2/data/response/response.dart';

const CACHE_HOME_KEY = "CACHE_HOME_KEY";
const CACHE_HOME_INTERVAL = 60000; // 1 minute

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeToCache(HomeResponse homeResponse);
}

class LocalDataSourceImpl extends LocalDataSource {
  Map<String, CachedItem> cacheMap = Map();

  @override
  Future<HomeResponse> getHomeData() async {
    // Map<String, CachedItem> Key --> CACHE_HOME_KEY & Value --> DATA
    // DATA (HomeResponse) = Key (CACHE_HOME_KEY)
    CachedItem? cachedItem = cacheMap[CACHE_HOME_KEY];
    if (cachedItem != null && cachedItem.setValid(CACHE_HOME_INTERVAL)) {
      return cachedItem.data;
    } else {
      return throw ErrorHandeler.handel(DataSource.CASHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeToCache(HomeResponse homeResponse) async {
    cacheMap[CACHE_HOME_KEY] = CachedItem(homeResponse);
  }
}

class CachedItem {
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool setValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
