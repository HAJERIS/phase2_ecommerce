import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../viewmodels/login_viewmodel.dart';
import '../products/products_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: const Text('Login')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                const SizedBox(height: 20),
                if (viewModel.errorMessage != null)
                  Text(
                    viewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ElevatedButton(
                  onPressed:
                      viewModel.isBusy
                          ? null
                          : () async {
                            final user = await viewModel.login(
                              usernameController.text.trim(),
                              passwordController.text.trim(),
                            );

                            if (user != null && context.mounted) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProductsView(),
                                ),
                              );
                            }
                          },

                  child:
                      viewModel.isBusy
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
