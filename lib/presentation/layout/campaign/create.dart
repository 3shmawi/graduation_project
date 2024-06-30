import 'dart:io';

import 'package:donation/app/config.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/layout/campaign/view_model.dart';
import 'package:easy_localization/easy_localization.dart';

class CreateCampaignPage extends StatefulWidget {
  const CreateCampaignPage({super.key});

  @override
  CreateCampaignPageState createState() => CreateCampaignPageState();
}

class CreateCampaignPageState extends State<CreateCampaignPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(AppStrings.createCampaign).tr(),
      ),
      body: BlocConsumer<CampaignsCtrl, CampaignsStates>(
        listener: (context, state) {
          if (state is GetCampaignsLoadedState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<CampaignsCtrl>();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const SizedBox(height: 20),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: cubit.titleController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: AppStrings.title.tr(),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterTitle.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: cubit.titleDescriptionController,
                    minLines: 5,
                    maxLines: 5,
                    maxLength: 80,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        hintText: AppStrings.titleDescription.tr()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterTitleDescription.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: cubit.aboutCampaignController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: AppStrings.aboutCampaign.tr()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterAboutCampaign.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: cubit.beneficiariesController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: AppStrings.beneficiaries.tr()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterBeneficiaries.tr();
                      }
                      if (int.tryParse(value) == null) {
                        return AppStrings.pleaseEnterValidNumber.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: cubit.selectedCategory,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: AppStrings.category.tr()),
                    items: AppConfigs.campaignCategories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category).tr(),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      cubit.changeCategory(newValue!);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseSelectCategory.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    style: Theme.of(context).textTheme.labelMedium,
                    controller: cubit.totalAmountController,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        labelText: AppStrings.totalAmount.tr()),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppStrings.pleaseEnterTotalAmount.tr();
                      }
                      if (double.tryParse(value) == null) {
                        return AppStrings.pleaseEnterValidNumber.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed:
                            cubit.isPostContainPhotos ? cubit.pickImages : null,
                        child: Text(
                          AppStrings.selectImages.tr(),
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: AppColors.white,
                                  ),
                        ),
                      ),
                      const Spacer(),
                      Switch(
                        value: cubit.isPostContainPhotos,
                        onChanged: cubit.changePostContainPhotos,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  cubit.images.isEmpty
                      ? const SizedBox()
                      : SizedBox(
                          height: 150,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) {
                              return const SizedBox(width: 10);
                            },
                            itemCount: cubit.images.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image.file(
                                      File(cubit.images[index].path),
                                      width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.black38,
                                    child: IconButton(
                                      onPressed: () {
                                        cubit.deleteImage(index);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        cubit.createCampaign();
                      }
                    },
                    child: Text(
                      AppStrings.submit.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                  if (state is CreateCampaignsLoadingState)
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: LinearProgressIndicator(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
