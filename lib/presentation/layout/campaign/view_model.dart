import 'package:dio/dio.dart';
import 'package:donation/app/api.dart';
import 'package:donation/app/config.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/domain/model/campaign.dart';
import 'package:donation/presentation/_resources/component/toast.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/services/dio_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class CampaignsCtrl extends Cubit<CampaignsStates> {
  CampaignsCtrl() : super(CampaignsInitialState());

  final _http = HttpUtil();

  final List<Campaign> campaigns = [];
  int currentFilterIndex = 0;

  void changeFilterIndex(int index) {
    currentFilterIndex = index;
    emit(
      GetCampaignsLoadedState(
        campaigns
            .where((campaigns) =>
                campaigns.category ==
                AppConfigs.campaignCategories[currentFilterIndex])
            .toList(),
      ),
    );
  }

  void getCampaigns() {
    campaigns.clear();
    emit(GetCampaignsLoadingState());
    _http.get(ApiUrl.getCampaigns).then((response) {
      ShowToast.success(response['status']);
      campaigns.addAll(CampaignModel.fromJson(response).data!.document!);
      emit(GetCampaignsLoadedState(
        campaigns
            .where((campaigns) =>
                campaigns.category ==
                AppConfigs.campaignCategories[currentFilterIndex])
            .toList(),
      ));
    }).catchError((error) {
      ShowToast.error(error.toString());

      emit(GetCampaignsErrorState());
    });
  }

  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();
  final aboutCampaignController = TextEditingController();
  final beneficiariesController = TextEditingController();
  final totalAmountController = TextEditingController();

  String? selectedCategory;

  void changeCategory(String category) {
    selectedCategory = category;
    emit(ChangeCategoryState());
  }

  void createCampaign() {
    if (images.isNotEmpty) {
      emit(CreateCampaignsLoadingState());
      try {
        _http.post(
          ApiUrl.createCampaign,
          data: {
            "userID": AuthCtrl.usrId,
            "title": titleController.text,
            "titleDescription": titleDescriptionController.text,
            "aboutCampaign": aboutCampaignController.text,
            "beneficiaries": int.parse(beneficiariesController.text),
            "category": selectedCategory,
            "remainingAmount": int.parse(totalAmountController.text),
            "totalAmount": int.parse(totalAmountController.text),
          },
        ).then((response) {
          for (int i = 0; i < images.length; i++) {
            _uploadPhotos(response['data']['document']['_id'], images[i],
                i == images.length - 1);
          }
        }).catchError((error) {
          emit(CreateCampaignsErrorState());
        });
      } catch (e) {
        ShowToast.warning("Just numbers for total amount and beneficiaries");
      }
    } else {
      ShowToast.error("Please select an image to upload");
    }
  }

  bool isPostContainPhotos = false;

  void changePostContainPhotos(bool isContainPhotos) {
    if (isPostContainPhotos) {
      images.clear();
    }
    isPostContainPhotos = isContainPhotos;
    emit(ChangeCampaignsContainPhotosState());
  }

  void deleteImage(int index) {
    images.removeAt(index);
    emit(DeleteImageState());
  }

  List<XFile> images = [];
  final ImagePicker _picker = ImagePicker();

  void pickImages() async {
    images.clear();
    images = await _picker.pickMultiImage();
    emit(SelectImagesState());
  }

  void _uploadPhotos(String campaignId, XFile image, bool isLast) async {
    final multipartImage = await MultipartFile.fromFile(
      image.path,
      filename: path.basename(image.path),
    );
    final formData = FormData.fromMap({
      "photo": multipartImage,
    });
    _http
        .patch(
      "/api/donationCampaigns/uploadDonationCampaignPhoto/$campaignId",
      data: formData,
    )
        .then((response) {
      if (isLast) {
        titleDescriptionController.clear();
        aboutCampaignController.clear();
        beneficiariesController.clear();
        totalAmountController.clear();
        titleController.clear();

        images.clear();
        isCampaignContainPhotos = false;
        getCampaigns();
      }
    }).catchError((error) {
      emit(CreateCampaignsErrorState());
    });
  }

  bool isCampaignContainPhotos = false;

  void changeCampaignContainPhotos(bool isContainPhotos) {
    if (isCampaignContainPhotos) {
      images.clear();
    }
    isCampaignContainPhotos = isContainPhotos;
    emit(ChangeCampaignsContainPhotosState());
  }

  void deleteCampaigns(Campaign campaign) {
    campaigns.remove(campaign);

    emit(GetCampaignsLoadingState());
    _http.delete(ApiUrl.deleteCampaign + campaign.id!).then((response) {
      ShowToast.success(response['status']);
      emit(GetCampaignsLoadedState(
        campaigns
            .where((campaigns) =>
                campaigns.category ==
                AppConfigs.campaignCategories[currentFilterIndex])
            .toList(),
      ));
    }).catchError((error) {
      ShowToast.error(error.toString());
      emit(GetCampaignsErrorState());
    });
  }

  void updateCampaigns(Campaign campaign) {
    int index = campaigns.indexOf(campaign);
    emit(GetCampaignsLoadingState());
    _http.delete(ApiUrl.updateCampaign + campaign.id!).then((response) {
      ShowToast.success(response['status']);
      // campaignss.remove(campaigns);
      campaigns[index].copyWith(
        title: titleController.text,
        titleDescription: titleDescriptionController.text,
        aboutCampaign: aboutCampaignController.text,
        beneficiaries: int.parse(beneficiariesController.text),
        category: selectedCategory,
        remainingAmount: int.parse(totalAmountController.text),
      );

      emit(GetCampaignsLoadedState(
        campaigns
            .where((campaigns) =>
                campaigns.category ==
                AppConfigs.campaignCategories[currentFilterIndex])
            .toList(),
      ));
    }).catchError((error) {
      ShowToast.error(error.toString());
      emit(GetCampaignsErrorState());
    });
  }

//payment
  final amountController = TextEditingController();

  void payment(String campaignId, String token) async {
    emit(PaymentLoadingState());

    _http.post(ApiUrl.payment, data: {
      "campaignId": campaignId,
      "amount": int.parse(amountController.text),
      "token": token,
      "userId": AuthCtrl.usrId,
    }).then((v) {
      ShowToast.success("Your payment method has been successfully");
      emit(PaymentLoadedState());
    }).catchError((e) {
      ShowToast.error(e.toString());
      emit(PaymentErrorState());
    });
  }
}

abstract class CampaignsStates {}

final class CampaignsInitialState extends CampaignsStates {}

final class CampaignsInitialTabState extends CampaignsStates {}

final class GetCampaignsLoadingState extends CampaignsStates {}

final class GetCampaignsLoadedState extends CampaignsStates {
  final List<Campaign> campaigns;

  GetCampaignsLoadedState(this.campaigns);
}

final class GetCampaignsErrorState extends CampaignsStates {}

final class CreateCampaignsLoadingState extends CampaignsStates {}

final class CreateCampaignsLoadedState extends CampaignsStates {}

final class CreateCampaignsErrorState extends CampaignsStates {}

final class PaymentLoadingState extends CampaignsStates {}

final class PaymentLoadedState extends CampaignsStates {}

final class PaymentErrorState extends CampaignsStates {}

//other
final class SelectImagesState extends CampaignsStates {}

final class DeleteImageState extends CampaignsStates {}

final class ChangeCategoryState extends CampaignsStates {}

final class ChangeCampaignsContainPhotosState extends CampaignsStates {}
