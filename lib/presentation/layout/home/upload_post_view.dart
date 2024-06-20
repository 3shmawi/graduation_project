import 'dart:io';

import 'package:donation/presentation/layout/home/view_model.dart';

import '../../../app/global_imports.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  UploadPostPageState createState() => UploadPostPageState();
}

class UploadPostPageState extends State<UploadPostPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCtrl, HomeStates>(
      listener: (context, state) {
        // if (state is CreatePostLoadedState) {
        //   final cubit = BlocProvider.of<HomeCtrl>(context, listen: false);
        //   cubit.contentCtrl.clear();
        //   cubit.changePostContainPhotos(false);
        //   cubit.images.clear();
        //   cubit.getPosts();
        // }
      },
      builder: (context, state) {
        final cubit = context.read<HomeCtrl>();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: cubit.contentCtrl,
                style: Theme.of(context).textTheme.labelMedium,
                decoration: const InputDecoration(
                  hintText: 'Content',
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed:
                        cubit.isPostContainPhotos ? cubit.pickImages : null,
                    child: Text(
                      'Select Images',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
                  ? const Expanded(child: SizedBox())
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: cubit.images.map((image) {
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Image.file(
                                File(image.path),
                                width: 100,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              if (!cubit.isPostContainPhotos) const Spacer(),
              ElevatedButton(
                onPressed: cubit.createPost,
                child: Text(
                  'Upload Post',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.white,
                      ),
                ),
              ),
              if (state is CreatePostLoadingState)
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: LinearProgressIndicator(),
                ),
            ],
          ),
        );
      },
    );
  }
}
