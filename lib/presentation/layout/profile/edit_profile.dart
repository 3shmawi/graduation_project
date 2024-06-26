import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:donation/app/config.dart';
import 'package:donation/app/global_imports.dart';
import 'package:donation/presentation/auth/auth_view_model.dart';
import 'package:donation/presentation/auth/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(AppStrings.editProfile).tr(),
      ),
      body: BlocConsumer<AuthCtrl, AuthStates>(
        buildWhen: (_, current) =>
            current is AuthLoginSuccessState ||
            current is AuthEditProfileLoadingState ||
            current is SelectImageState,
        listenWhen: (_, current) => current is AuthLoginSuccessState,
        listener: (context, state) {
          if (state is AuthLoginSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCtrl>();
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        cubit.image != null
                            ? CircleAvatar(
                                radius: 83,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      FileImage(File(cubit.image!.path)),
                                ),
                              )
                            : CircleAvatar(
                                radius: 83,
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.grey[300],
                                  backgroundImage:
                                      const CachedNetworkImageProvider(
                                          AppConfigs.defaultImg),
                                ),
                              ),
                        CircleAvatar(
                          backgroundColor: Colors.black38,
                          child: IconButton(
                            icon: const Icon(CupertinoIcons.camera),
                            onPressed: cubit.pickImage,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: AppHeight.h30,
                    ),
                    AuthFormField(
                      controller: cubit.nameCtrl,
                      hintTxt: AppStrings.usrName,
                      prefixIcon: CupertinoIcons.profile_circled,
                    ),
                    const SizedBox(
                      height: AppHeight.h48,
                    ),
                    ElevatedButton(
                      onPressed: cubit.updateProfile,
                      child: Text(
                        AppStrings.editProfile.tr(),
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                    if (state is AuthEditProfileLoadingState)
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
