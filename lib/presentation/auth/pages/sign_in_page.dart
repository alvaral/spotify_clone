import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:spotify_clone_flutter/common/widgets/appbar/basic_app_bar.dart';
import 'package:spotify_clone_flutter/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone_flutter/core/configs/assets/app_vectors.dart';
import 'package:spotify_clone_flutter/core/routing/app_router.dart';
import 'package:spotify_clone_flutter/data/models/auth/sign_in_user_req.dart';
import 'package:spotify_clone_flutter/domain/usecases/auth/sign_in_use_case.dart';
import 'package:spotify_clone_flutter/service_locator.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO -> change params when its dev mode
    _email.text = 'test@gmail.com';
    _password.text = "test123";

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
              _userText(),
              const SizedBox(height: 50),
              _fullNameField(context),
              const SizedBox(height: 20),
              _passwordField(context),
              const SizedBox(height: 30),
              BasicAppButton(
                  onPressed: () async {
                    var result = await sl<SignInUseCase>().call(
                      params: SignInUserReq(
                        email: _email.text,
                        password: _password.text,
                      ),
                    );
                    result.fold(
                      (l) {
                        var snackBar = SnackBar(content: Text(l));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      (r) {
                        context.pushReplacement('/${AppRoute.home.name}');
                      },
                    );
                  },
                  title: 'Sign In'),
            ],
          ),
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
      controller: _email,
      decoration: const InputDecoration(hintText: 'Enter Username or Email')
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
            'Not a member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              context.goNamed(AppRoute.register.name);
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
