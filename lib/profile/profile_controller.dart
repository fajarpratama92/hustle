import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hustle_house_flutter/model/active_subscribe.dart';
import 'package:hustle_house_flutter/model/complimentary_vouchers.dart' as comp;
import 'package:hustle_house_flutter/model/discount_vouchers.dart' as disc;
import 'package:hustle_house_flutter/model/upcoming_class.dart';
import 'package:hustle_house_flutter/pages/home/home_controller.dart';
import 'package:hustle_house_flutter/pages/login/login_page.dart';
import 'package:hustle_house_flutter/utils/api/endpoint.dart';
import 'package:hustle_house_flutter/utils/my_pref.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../model/booking_history_cancelled.dart' as cancelled;
import '../model/booking_history_completed.dart' as completed;
import '../model/credit_expired_history.dart';
import '../model/credit_valid_history.dart';
import '../model/credit_valid_history.dart' as cValidHistory;
import '../model/package_history.dart';
import '../model/referral_code.dart';
import '../model/referral_list.dart';
import '../model/user_profile.dart';
import '../model/voucher.dart';
import '../model/voucher_history.dart';
import '../model/voucher_history.dart' as vHistory;
import '../utils/api/rest_api_controller.dart';
import '../utils/home_bindings.dart';

class ProfileController extends GetxController {
  RxBool isLoadingProfile = false.obs;
  RxBool isLoadingHistory = false.obs;
  RxBool isLoadingHistoryCancelled = false.obs;
  RxBool isLoadingHistoryCompleted = false.obs;
  RxBool isLoadingCreditValidHistory = false.obs;
  RxBool isLoadingCreditExpiredHistory = false.obs;
  RxBool isLoadingVoucherHistory = false.obs;
  RxBool isLoadingPackageHistory = false.obs;
  RxBool isLoadingDiscountVoucher = false.obs;
  RxBool isLoadingComplimentaryVoucher = false.obs;
  RxBool isLoadingUpcoming = false.obs;
  RxBool isLoadingDelete = false.obs;
  RxBool isLoadingReferralCode = false.obs;
  RxBool isLoadingReferralList = false.obs;
  RxBool isLoadMoreHistory = false.obs;
  RxBool isLoadMoreHistoryCancelled = false.obs;
  RxBool isLoadMoreHistoryCompleted = false.obs;
  RxBool isLoadMoreCreditValid = false.obs;
  RxBool isLoadMoreCreditExpired = false.obs;
  RxBool isLoadMoreVoucher = false.obs;
  RxBool isLoadMorePackage = false.obs;
  RxBool isLoadingLogout = false.obs;

  Rxn<UserProfile> userProfile = Rxn();

  Rxn<cancelled.BookingHistoryCancelled> bookingHistoryCancelled = Rxn();
  Rxn<completed.BookingHistoryCompleted> bookingHistoryCompleted = Rxn();
  Rxn<CreditValidHistory> creditValidHistory = Rxn();
  Rxn<CreditExpiredHistory> creditExpiredHistory = Rxn();
  Rxn<VoucherHistory> voucherHistory = Rxn();
  Rxn<vHistory.VoucherHistory> vouchersHistory = Rxn();
  Rxn<disc.DiscountVouchers> discountVoucher = Rxn();
  Rxn<comp.ComplimentaryVouchers> complimentaryVoucher = Rxn();
  Rxn<PackageHistory> packageHistory = Rxn();
  Rxn<UpcomingClass> upcomingClass = Rxn();
  Rxn<ReferralCode> referralCode = Rxn();
  Rxn<ReferralList> referralList = Rxn();
  RxList<ActiveSubscribe> activeSubscribe = RxList();

  final RestApiController restApiController = Get.find<RestApiController>();
  Rx<int> isFuture = Rx(0);
  Rx<double> limit = Rx(10);
  int page = 1;
  int pageHistoryCompleted = 1;
  int pageCreditValid = 1;
  Rx<int> currentPageCreditValid = Rx(1);
  Rx<int> lastPageCreditValid = Rx(1);
  Rx<int> currentPageCreditExpired = Rx(1);
  Rx<int> lastPageCreditExpired = Rx(1);
  RxInt totalPurchaseList = 0.obs;
  int pageCreditExpired = 1;
  int pageVoucher = 1;
  int pagePackage = 1;
  final int _creditValidType = 1;
  final int _creditExpiredType = 2;
  final int _voucherType = 3;
  final int _packageType = 4;
  var isActive = 0.obs;
  final int _discountType = 1;
  final int _complimentaryType = 2;
  bool isShowChangePassword = false;

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
    getBookingHistoryCancelled();
    getBookingHistoryCompleted();
    getCreditValidHistory();
    getCreditExpiredHistory();
    getVoucherHistory();
    getPackageHistory();
    getAvailableDiscountVoucher();
    getAvailableComplimentaryVoucher();
    getUpcomingClass();
    fetchMembershipCodeFromApi();
    _getReferralCode();
    _getReferralList();
    getActiveSubscribe();
  }

  String loginTypeIcon(String loginType) {
    switch (loginType) {
      case 'email':
        return "assets/images/ic_email.svg";
      case 'google':
        return "assets/images/ic_google.svg";
      case 'facebook':
        return "assets/images/ic_facebook_blue.svg";
      default:
        return 'invalid type';
    }
  }

  String getSportClassIconCancel(cancelled.SportsClass? sportsClass) {
    switch (sportsClass?.name) {
      case 'KISS MY ABS':
        return 'assets/images/ic_kiss_my_abs.svg';
      case 'AWAKEN THE FORCE':
        return 'assets/images/ic_force.svg';
      case 'MACHINE GUNS':
        return 'assets/images/ic_machine_guns.svg';
      case 'UNITED WE SWEAT':
        return 'assets/images/ic_united.svg';
      case 'Sport Massage':
        return 'assets/images/ic_sport_massage.svg';
      case 'Ice Bath':
        return 'assets/images/ic_bath.svg';
      default:
        return 'Invalid class';
    }
  }

  String getSportClassIconComplete(completed.SportsClass? sportsClass) {
    switch (sportsClass?.name) {
      case 'KISS MY ABS':
        return 'assets/images/ic_kiss_my_abs.svg';
      case 'AWAKEN THE FORCE':
        return 'assets/images/ic_force.svg';
      case 'MACHINE GUNS':
        return 'assets/images/ic_machine_guns.svg';
      case 'UNITED WE SWEAT':
        return 'assets/images/ic_united.svg';
      case 'Sport Massage':
        return 'assets/images/ic_sport_massage.svg';
      case 'Ice Bath':
        return 'assets/images/ic_bath.svg';
      default:
        return 'Invalid class';
    }
  }

  String getUpcomingSportClassIcon(UpcomingSportsClass? sportsClass) {
    switch (sportsClass?.name) {
      case 'KISS MY ABS':
        return 'assets/images/ic_kiss_my_abs.svg';
      case 'AWAKEN THE FORCE':
        return 'assets/images/ic_force.svg';
      case 'MACHINE GUNS':
        return 'assets/images/ic_machine_guns.svg';
      case 'UNITED WE SWEAT':
        return 'assets/images/ic_united.svg';
      case 'Sport Massage':
        return 'assets/images/ic_sport_massage.svg';
      default:
        return 'Invalid class';
    }
  }

  void getUserProfile() async {
    isLoadingProfile.value = true;
    var myCredit = Get.find<MyPref>().myCredit;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.userProfile);
      userProfile.value = UserProfile.fromJson(response.data['data']);
      isLoadingProfile.value = false;
      isShowChangePassword = userProfile.value?.loginType == 'email';
      myCredit.val =
          userProfile.value?.member?.remainingCredit.toString() ?? '0';
      update();
    } on DioException catch (e) {
      isLoadingProfile.value = false;
      update();
      log('error user profile ${e.message}');
    }
  }

  Future getBookingHistoryCancelled() async {
    isLoadingHistoryCancelled.value = true;
    isLoadMoreHistoryCancelled.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'isFuture': isFuture,
        'limit': limit,
        'page': page
      };
      var response = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCancelled,
          queryParameters: queryParameter);
      bookingHistoryCancelled.value =
          cancelled.BookingHistoryCancelled.fromJson(response.data['data']);
      isLoadingHistoryCancelled.value = false;
      isLoadMoreHistoryCancelled.value = true;
      update();
    } on DioException catch (e) {
      isLoadingHistoryCancelled.value = false;
      isLoadMoreHistoryCancelled.value = false;
      update();
      log('error booking history cancelled ${e.message}');
    }
  }

  Future getBookingHistoryCompleted() async {
    isLoadingHistoryCompleted.value = true;
    isLoadMoreHistoryCompleted.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'isFuture': 0,
        'limit': 5,
        'page': 1
      };
      var response = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCompleted,
          queryParameters: queryParameter);
      bookingHistoryCompleted.value =
          completed.BookingHistoryCompleted.fromJson(response.data['data']);
      isLoadingHistoryCompleted.value = false;
      isLoadMoreHistoryCompleted.value = true;
      Get.find<HomeController>()
          .getCompletedBooking(bookingHistoryCompleted.value);
      update();
    } on DioException catch (e) {
      isLoadingHistoryCompleted.value = false;
      isLoadMoreHistoryCompleted.value = false;
      update();
      log('error booking history completed ${e.message}');
    }
  }

  Future getCreditValidHistory() async {
    isLoadingCreditValidHistory.value = true;
    isLoadMoreCreditValid.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': page,
        'type': _creditValidType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      creditValidHistory.value = CreditValidHistory.fromJson(response.data);
      currentPageCreditValid.value =
          creditValidHistory.value!.data!.currentPage!;
      lastPageCreditValid.value = creditValidHistory.value!.data!.lastPage!;
      isLoadingCreditValidHistory.value = false;
      isLoadMoreCreditValid.value = true;
      update();
    } on DioException catch (e) {
      isLoadingCreditValidHistory.value = false;
      isLoadMoreCreditValid.value = false;
      update();
      log('error credit valid history ${e.message}');
    }
  }

  Future getCreditExpiredHistory() async {
    isLoadingCreditExpiredHistory.value = true;
    isLoadMoreCreditExpired.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': page,
        'type': _creditExpiredType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      creditExpiredHistory.value =
          CreditExpiredHistory.fromJson(response.data['data']);
      currentPageCreditExpired.value = creditExpiredHistory.value!.currentPage!;
      lastPageCreditExpired.value = creditExpiredHistory.value!.lastPage!;
      isLoadingCreditExpiredHistory.value = false;
      isLoadMoreCreditExpired.value = true;
      update();
    } on DioException catch (e) {
      isLoadingCreditExpiredHistory.value = false;
      isLoadMoreCreditExpired.value = false;
      update();
      log('error credit expired history ${e.message}');
    }
  }

  double getCreditValidContainerHeight(cValidHistory.Data credit) {
    double height = 0;
    double deviceHeight = Get.height;

    if (deviceHeight < 900) {
      if (credit.data!.length >= 3) {
        height = deviceHeight / 2.95;
      } else if (credit.data!.length == 2) {
        height = deviceHeight / 2.95 - 90;
      } else if (credit.data!.length == 1) {
        height = deviceHeight / 2.95 - 180;
      }
    } else {
      if (credit.data!.length > 3) {
        height = deviceHeight / 2.75;
      } else if (credit.data!.length == 3) {
        height = deviceHeight / 2.75 - 65;
      } else if (credit.data!.length == 2) {
        height = deviceHeight / 2.75 - 155;
      } else if (credit.data!.length == 1) {
        height = deviceHeight / 2.75 - 250;
      }
    }
    return height;
  }

  double getCreditExpiredContainerHeight(cValidHistory.Data credit) {
    double height = 0;
    double deviceHeight = Get.height;

    if (deviceHeight < 900) {
      if (credit.data!.length >= 3) {
        height = deviceHeight / 3.25;
      } else if (credit.data!.length == 2) {
        height = deviceHeight / 3.25 + 90;
      } else if (credit.data!.length == 1) {
        height = deviceHeight / 3.25 + 180;
      }
    } else {
      if (credit.data!.length > 3) {
        height = deviceHeight / 2.6;
      } else if (credit.data!.length == 3) {
        height = deviceHeight / 2.6 + 10;
      } else if (credit.data!.length == 2) {
        height = deviceHeight / 2.6 + 100;
      } else if (credit.data!.length == 1) {
        height = deviceHeight / 2.6 + 190;
      }
    }
    return height;
  }

  Future getVoucherHistory() async {
    isLoadingVoucherHistory.value = true;
    isLoadMoreVoucher.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': page,
        'type': _voucherType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      voucherHistory.value = VoucherHistory.fromJson(response.data['data']);
      isLoadingVoucherHistory.value = false;
      isLoadMoreVoucher.value = true;
      update();
    } on DioException catch (e) {
      isLoadingVoucherHistory.value = false;
      isLoadMoreVoucher.value = false;
      update();
      log('error voucher history ${e.message}');
    }
  }

  Future getPackageHistory() async {
    isLoadingPackageHistory.value = true;
    isLoadMorePackage.value = false;
    update();
    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': page,
        'type': _packageType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);
      packageHistory.value = PackageHistory.fromJson(response.data['data']);
      isLoadingPackageHistory.value = false;
      isLoadMorePackage.value = true;
      update();
    } on DioException catch (e) {
      isLoadingPackageHistory.value = false;
      isLoadMorePackage.value = false;
      update();
      log('error package history ${e.message}');
    }
  }

  Future getAvailableDiscountVoucher() async {
    isLoadingDiscountVoucher.value = true;
    update();
    try {
      final queryParameter = {
        'type': _discountType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.availableVoucher, queryParameters: queryParameter);
      discountVoucher.value = disc.DiscountVouchers.fromJson(response.data);
      isLoadingDiscountVoucher.value = false;
      update();
    } on DioException catch (e) {
      isLoadingDiscountVoucher.value = false;
      update();
      log('error discount voucher ${e.message}');
    }
  }

  Future getAvailableComplimentaryVoucher() async {
    isLoadingComplimentaryVoucher.value = true;
    update();
    try {
      final queryParameter = {
        'type': _complimentaryType,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.availableVoucher, queryParameters: queryParameter);
      complimentaryVoucher.value =
          comp.ComplimentaryVouchers.fromJson(response?.data);
      isLoadingComplimentaryVoucher.value = false;
      if (Get.isRegistered<HomeController>()) {
        var responseVoucher = List<Voucher>.from(
            response.data["data"].map((x) => Voucher.fromJson(x)));
        Get.find<HomeController>().getVouchers(responseVoucher);
      }
      update();
    } on DioException catch (e) {
      isLoadingComplimentaryVoucher.value = false;
      update();
      log('error complimentary voucher ${e.message}');
    }
  }

  List<vHistory.Datum> getUniqueVouchers(List<vHistory.Datum>? vouchers) {
    final uniqueVouchers = <vHistory.Datum>[];
    final seenVouchers = <String>[];

    for (final voucher in vouchers ?? []) {
      if (!seenVouchers.contains(voucher.code)) {
        uniqueVouchers.add(voucher);
        seenVouchers.add(voucher.code!);
      }
    }

    return uniqueVouchers;
  }

  List<disc.Datum> getUniqueDiscountVouchers(List<disc.Datum>? vouchers) {
    final uniqueVouchers = <disc.Datum>[];
    final seenVouchers = <String>[];

    for (final voucher in vouchers ?? []) {
      if (!seenVouchers.contains(voucher.rewardVoucher!.name)) {
        uniqueVouchers.add(voucher);
        seenVouchers.add(voucher.rewardVoucher!.name!);
      }
    }

    return uniqueVouchers;
  }

  List<comp.Datum> getUniqueComplimentaryVouchers(List<comp.Datum>? vouchers) {
    final uniqueVouchers = <comp.Datum>[];
    final seenVouchers = <String>[];

    for (final voucher in vouchers ?? []) {
      if (!seenVouchers.contains(voucher.rewardVoucher!.code)) {
        uniqueVouchers.add(voucher);
        seenVouchers.add(voucher.rewardVoucher!.code!);
      }
    }

    return uniqueVouchers;
  }

  int getVoucherCount(vHistory.Datum voucher, List<vHistory.Datum>? vouchers) {
    int count = 0;

    for (final voucherData in vouchers ?? []) {
      if (voucherData.code == voucher.code) {
        count++;
      }
    }

    return count;
  }

  int getDiscountVoucherCount(disc.Datum voucher, List<disc.Datum>? vouchers) {
    int count = 0;

    for (final voucherData in vouchers ?? []) {
      if (voucherData.rewardVoucher!.name == voucher.rewardVoucher!.name) {
        count++;
      }
    }

    return count;
  }

  int getComplimentaryVoucherCount(
      comp.Datum voucher, List<comp.Datum>? vouchers) {
    int count = 0;

    for (final voucherData in vouchers ?? []) {
      if (voucherData.rewardVoucher!.code == voucher.rewardVoucher!.code) {
        count++;
      }
    }

    return count;
  }

  Future _getReferralCode() async {
    isLoadingReferralCode.value = true;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.referralCode);
      referralCode.value = ReferralCode.fromJson(response.data);
      isLoadingReferralCode.value = false;
      update();
    } on DioException catch (e) {
      isLoadingReferralCode.value = false;
      update();
      log('error referral code ${e.message}');
    }
  }

  Future _getReferralList() async {
    isLoadingReferralList.value = true;
    update();
    try {
      var response =
          await restApiController.get(endpoint: Endpoint.referralList);
      referralList.value = ReferralList.fromJson(response.data);
      isLoadingReferralList.value = false;
      update();
    } on DioException catch (e) {
      isLoadingReferralList.value = false;
      update();
      log('error referral list ${e.message}');
    }
  }

  void loadNextPageHistoryCancelled() async {
    isLoadingHistoryCancelled.value = true;
    isLoadMoreHistoryCancelled.value = false;
    update();
    try {
      page++;
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'isFuture': isFuture,
        'limit': limit,
        'page': page
      };

      final newBookingHistory = await restApiController.get(
          endpoint: Endpoint.bookingHistoryCancelled,
          queryParameters: queryParameter);

      if (newBookingHistory != null) {
        final newData = cancelled.BookingHistoryCancelled.fromJson(
            newBookingHistory.data['data']);
        for (int i = 0; i < newData.data!.length; i++) {
          bookingHistoryCancelled.value?.data?.add(newData.data![i]);
        }
        isLoadingHistoryCancelled.value = false;
        isLoadMoreHistoryCancelled.value =
            (bookingHistoryCancelled.value?.data?.length ?? 0) < newData.total;
        isLoadMoreHistoryCancelled.value = true;
        update();
      }
    } on DioException catch (e) {
      isLoadingHistoryCancelled.value = false;
      isLoadMoreHistoryCancelled.value = false;
      log('error next page booking history cancelled ${e.message}');
    }
  }

  void loadNextCreditValid() async {
    isLoadingCreditValidHistory.value = true;
    isLoadMoreCreditValid.value = false;
    update();
    try {
      if (currentPageCreditValid.value < lastPageCreditValid.value) {
        currentPageCreditValid.value++;
      }
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': currentPageCreditValid.value,
        'type': _creditValidType
      };

      final newCreditValidHistory = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);

      if (newCreditValidHistory != null) {
        final newData = CreditValidHistory.fromJson(newCreditValidHistory.data);
        for (int i = 0; i < newData.data!.data!.length; i++) {
          creditValidHistory.value?.data?.data?.add(newData.data!.data![i]);
        }
        currentPageCreditValid.value = newData.data!.currentPage!;
        lastPageCreditValid.value = newData.data!.lastPage!;
        isLoadingCreditValidHistory.value = false;
        isLoadMoreCreditValid.value =
            (creditValidHistory.value?.data!.data!.length ?? 0) <
                newData.data!.total;
        isLoadMoreCreditValid.value = true;
        update();
      }
    } on DioException catch (e) {
      isLoadingCreditValidHistory.value = false;
      isLoadMoreCreditValid.value = false;
      log('error next page Credit Valid history ${e.message}');
    }
  }

  void loadNextCreditExpired() async {
    isLoadingCreditExpiredHistory.value = true;
    isLoadMoreCreditExpired.value = false;
    update();
    try {
      if (currentPageCreditExpired.value < lastPageCreditExpired.value) {
        currentPageCreditExpired.value++;
      }
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': currentPageCreditExpired.value,
        'type': _creditExpiredType
      };

      final newCreditExpiredHistory = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);

      if (newCreditExpiredHistory != null) {
        final newData =
            CreditExpiredHistory.fromJson(newCreditExpiredHistory.data['data']);
        for (int i = 0; i < newData.data!.length; i++) {
          creditExpiredHistory.value?.data?.add(newData.data![i]);
        }
        currentPageCreditExpired.value = newData.currentPage!;
        lastPageCreditExpired.value = newData.lastPage!;
        isLoadingCreditExpiredHistory.value = false;
        isLoadMoreCreditExpired.value =
            (creditExpiredHistory.value?.data?.length ?? 0) < newData.total;
        isLoadMoreCreditExpired.value = true;
        update();
      }
    } on DioException catch (e) {
      isLoadingCreditExpiredHistory.value = false;
      isLoadMoreCreditExpired.value = false;
      log('error next page CreditExpired history ${e.message}');
    }
  }

  void loadNextVoucher() async {
    isLoadingVoucherHistory.value = true;
    isLoadMoreVoucher.value = false;
    update();
    try {
      pageVoucher++;
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': pageVoucher,
        'type': _voucherType
      };

      final newVoucherHistory = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);

      if (newVoucherHistory != null) {
        final newData = VoucherHistory.fromJson(newVoucherHistory.data['data']);
        for (int i = 0; i < newData.data!.length; i++) {
          voucherHistory.value?.data?.add(newData.data![i]);
        }
        isLoadingVoucherHistory.value = false;
        isLoadMoreVoucher.value =
            (voucherHistory.value?.data?.length ?? 0) < newData.total!;
        isLoadMoreVoucher.value = true;
        update();
      }
    } on DioException catch (e) {
      isLoadingVoucherHistory.value = false;
      isLoadMoreVoucher.value = false;
      log('error next page Voucher history ${e.message}');
    }
  }

  void loadNextPackage() async {
    isLoadingPackageHistory.value = true;
    isLoadMorePackage.value = false;
    update();
    try {
      pagePackage++;
      final queryParameter = {
        'memberID': userProfile.value?.id,
        'limit': limit,
        'page': pagePackage,
        'type': _packageType
      };

      final newPackageHistory = await restApiController.get(
          endpoint: Endpoint.purchaseHistory, queryParameters: queryParameter);

      if (newPackageHistory != null) {
        final newData = PackageHistory.fromJson(newPackageHistory.data['data']);
        for (int i = 0; i < newData.data!.length; i++) {
          packageHistory.value?.data?.add(newData.data![i]);
        }
        isLoadingPackageHistory.value = false;
        isLoadMorePackage.value =
            (packageHistory.value?.data?.length ?? 0) < newData.total;
        isLoadMorePackage.value = true;
        update();
      }
    } on DioException catch (e) {
      isLoadingPackageHistory.value = false;
      isLoadMorePackage.value = false;
      log('error next page Package history ${e.message}');
    }
  }

  void getUpcomingClass() async {
    isLoadingUpcoming.value = true;
    update();

    try {
      final queryParameter = {
        'memberID': userProfile.value?.id,
      };
      var response = await restApiController.get(
          endpoint: Endpoint.upcomingClass, queryParameters: queryParameter);
      upcomingClass.value = UpcomingClass.fromJson(response.data['data']);
      isLoadingUpcoming.value = false;
      update();
    } on DioException catch (e) {
      isLoadingUpcoming.value = false;
      update();
      log('error upcoming class ${e.message}');
    }
  }

  void deleteAccount() async {
    isLoadingDelete.value = true;
    update();

    try {
      var parameter = {"email": userProfile.value?.email};
      var response = await restApiController.post(
          endpoint: Endpoint.deleteAccount, data: parameter);
      if (response?.statusCode == 200) {
        Get.offAll(() => LoginPage(), binding: HomeBindings());
        var accessToken = Get.find<MyPref>().accessToken;
        accessToken.val = '';
      }
      isLoadingDelete.value = false;
      update();
    } on DioException catch (e) {
      isLoadingDelete.value = false;
      update();
      log('error deleting account ${e.message}');
    }
  }

  void fetchMembershipCodeFromApi() async {
    try {
      //print('Debug member code 1');
      var response = await restApiController.get(endpoint: Endpoint.memberCode);
      if (response.data['status'] == true) {
        isActive.value = response.data['data']['isActive'];
        update();
      }
    } on DioException catch (e) {
      update();
      log('error fetch membershipcode data ${e.message}');
    }
  }

  void logout() async {
    isLoadingLogout.value = true;
    update();

    try {
      var response = await restApiController.get(endpoint: Endpoint.logout);
      if (response?.statusCode == 200) {
        Get.offAll(() => LoginPage(), binding: HomeBindings());
        var accessToken = Get.find<MyPref>().accessToken;
        accessToken.val = '';
        OneSignal.logout();
      }
      isLoadingLogout.value = false;
      update();
    } on DioException catch (e) {
      isLoadingLogout.value = false;
      update();
      log('error logout ${e.message}');
    }
  }

  void getActiveSubscribe() {
    if (Get.isRegistered<HomeController>()) {
      activeSubscribe.value = Get.find<HomeController>().activeSubscribe;
      update();
    }
  }

  void getTotalPurchaseList() async {
    int waiting = 0;
    try {
      final queryParameterWaiting = {'page': 1, 'limit': 1, 'type': 'waiting'};
      var responseWaiting = await restApiController.get(
          endpoint: Endpoint.purchaseList,
          queryParameters: queryParameterWaiting);
      waiting = responseWaiting?.data['data']['total'];
      totalPurchaseList.value = waiting;
    } on DioException catch (e) {
      log('error purchase list ${e.message}');
    }
  }
}
