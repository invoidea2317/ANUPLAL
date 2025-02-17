
import 'package:anuplal/app/models/profile_model.dart';
import 'package:get/get.dart';

import '../app/services/api_services.dart';
import '../app/models/community_model.dart';

class CommunityController extends GetxController implements GetxService {
  bool _isLoading = true;

  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  CommunityDetails _community = CommunityDetails(
    currentPage: 0,
    data: [],
    firstPageUrl: '',
    from: 0,
    lastPage: 0,
    lastPageUrl: '',
    links: [],
    nextPageUrl: '', path: '', perPage: 0, prevPageUrl: '', to: 0, total: 0,);

  CommunityDetails get community => _community;

  void setCommunity(CommunityDetails data) {
    _community = data;
    update();
  }

  Future<void> fetchCommunity() async {
    _isLoading = true;
    await apiService.fetchCommunity(this);
    _isLoading = false;

  }
}
