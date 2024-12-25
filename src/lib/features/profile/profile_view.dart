import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps/features/profile/profile_viewmodel.dart';
import 'package:todo_apps/ui/common/ui_helpers.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: viewModel.logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (viewModel.modelError != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  viewModel.modelError.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            CircleAvatar(
              radius: 50,
              backgroundImage: viewModel.user?.avatarUrl != null
                  ? NetworkImage(viewModel.user!.avatarUrl!)
                  : null,
              child: viewModel.user?.avatarUrl == null
                  ? const Icon(Icons.person, size: 50)
                  : null,
            ),
            verticalSpaceMedium,
            TextField(
              onChanged: viewModel.setUsername,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: viewModel.user?.username),
            ),
            verticalSpaceMedium,
            ElevatedButton(
              onPressed: viewModel.isBusy ? null : viewModel.updateProfile,
              child: viewModel.isBusy
                  ? const CircularProgressIndicator()
                  : const Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(BuildContext context) => ProfileViewModel();

  @override
  void onViewModelReady(ProfileViewModel viewModel) => viewModel.init();
}
