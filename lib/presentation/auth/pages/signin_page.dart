import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_flutter/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_flutter/presentation/auth/pages/signup_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

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
            _userText(),
            const SizedBox(height: 50),
            _fullNameField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 30),
            BasicAppButton(onPressed: () {}, title: 'Sign In'),
          ],
        ),
      ),
      bottomNavigationBar: _signInText(context),
    );
  }

  Widget _userText() {
    return const Text(
      'Sign In',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
    );
  }

  Widget _fullNameField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(hintText: 'Enter Username or Email')
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
            'Not a member?',
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
                  builder: (BuildContext context) => const SignUpPage(),
                ),
              );
            },
            child: const Text(
              'Register now',
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
