import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone_flutter/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_flutter/data/models/auth/create_user_req.dart';
import 'package:spotify_clone_flutter/domain/usecases/auth/signup_use_case.dart';
import 'package:spotify_clone_flutter/presentation/auth/pages/sign_in_page.dart';
import 'package:spotify_clone_flutter/presentation/home/pages/home_page.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

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
      body: SingleChildScrollView(
        child: Padding(
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
              BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SignUpUseCase>().call(
                      params: CreateUserReq(
                        email: _email.text,
                        password: _password.text,
                        fullName: _fullName.text,
                      ),
                    );

                    result.fold(
                      (l) {
                        var snackBar = SnackBar(content: Text(l));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      (r) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => HomePage(),
                            ),
                            (route) => false);
                      },
                    );
                  },
                  title: 'Create Account'),
            ],
          ),
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
      controller: _fullName,
      decoration: const InputDecoration(hintText: 'Full Name')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(hintText: 'Enter Email')
          .applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
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
                  builder: (BuildContext context) => SignInPage(),
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
