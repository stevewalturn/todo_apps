import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:todo_apps/features/auth/register_viewmodel.dart';
import 'package:todo_apps/ui/common/ui_helpers.dart';

class RegisterView extends StackedView<RegisterViewModel> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    RegisterViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              TextField(
                onChanged: viewModel.setUsername,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceMedium,
              TextField(
                onChanged: viewModel.setEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceMedium,
              TextField(
                onChanged: viewModel.setPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceMedium,
              TextField(
                onChanged: viewModel.setConfirmPassword,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                  border: OutlineInputBorder(),
                ),
              ),
              verticalSpaceLarge,
              ElevatedButton(
                onPressed: viewModel.isBusy ? null : viewModel.register,
                child: viewModel.isBusy
                    ? const CircularProgressIndicator()
                    : const Text('Register'),
              ),
              verticalSpaceMedium,
              TextButton(
                onPressed: viewModel.navigateToLogin,
                child: const Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  RegisterViewModel viewModelBuilder(BuildContext context) =>
      RegisterViewModel();
}
