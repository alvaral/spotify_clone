import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_flutter/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_flutter/presentation/auth/pages/signin_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 50,
          horizontal: 30,
        ),
        child: Column(
          children: [
            _registerText(),
            const SizedBox(height: 50),
            _fullNameField(context),
            const SizedBox(height: 20),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 30),
            BasicAppButton(onPressed: () {}, title: 'Create Account'),
          ],
        ),
      ),
      bottomNavigationBar: _signInText(context),
    );
  }

  Widget _registerText() {
    return const Text(
      'Register',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Full Name')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Password')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signInText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Do you yave an account?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const SignInPage(),
                ),
              );
            },
            child: const Text(
              'Sign In',
              style: TextStyle(
                color: Color(0xff288CE9),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          )
        ],
      ),
    );
  }
}
