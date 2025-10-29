import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:glint_frontend/design/common/custom_snackbar.dart';
import 'package:glint_frontend/design/exports.dart';
import 'package:glint_frontend/features/auth/blocs/register/register_cubit.dart';
import 'package:glint_frontend/navigation/glint_all_routes.dart';
import 'package:glint_frontend/utils/logger.dart';
import 'package:go_router/go_router.dart';

import '../onboarding/on_boarding_cubit.dart';

class CreateAccounScreen extends StatefulWidget {
  final bool isAdmin;

  const CreateAccounScreen({super.key, required this.isAdmin});

  @override
  State<CreateAccounScreen> createState() => _CreateAccounScreenState();
}

class _CreateAccounScreenState extends State<CreateAccounScreen> {
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _organizationController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _contactFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _organizationFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _organizationController.dispose();
    _confirmPasswordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _organizationFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  void _handleFocus(FocusNode focusNode) {
    setState(() => focusNode.requestFocus());
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconTextFieldType type,
    required FocusNode focusNode,
    required String hintText,
  }) {
    return AuthIconTextField(
      controller: controller,
      type: type,
      focusNode: focusNode,
      hintText: hintText,
      isTextFieldFocused: focusNode.hasFocus,
      onTap: () => _handleFocus(focusNode),
    );
  }

  Widget _buildLoginText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: AppTheme.simpleText,
        children: [
          const TextSpan(text: "Already have an account? "),
          TextSpan(
            text: "Login now",
            style: const TextStyle(
              color: AppColours.primaryBlue,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.w600,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Handle Login tap
                // context.read<RegisterCubit>().registerUser();
              },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    _emailController.addListener(() {
      context.read<RegisterCubit>().enteredEmail(_emailController.text);
    });

    _passwordController.addListener(() {
      context.read<RegisterCubit>().enteredPassword(_passwordController.text);
    });

    _confirmPasswordController.addListener(() {
      context
          .read<RegisterCubit>()
          .enteredConfirmPassword(_confirmPasswordController.text);
    });

    _nameController.addListener(() {
      context.read<RegisterCubit>().enteredUserName(_nameController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listenWhen: (previous, current) {
        if (previous.error != current.error) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state.isRegisteredSuccessfully) {
          if (context.mounted) {
            context.goNamed(state.navigateToRoute);
          }
        }
        if (!state.isEmailValid && state.error.isNotEmpty) {
          showCustomSnackbar(context, message: state.error, isError: true);
        }

        if (!state.isPassWordValid && state.error.isNotEmpty) {
          showCustomSnackbar(context, message: state.error, isError: true);
        }

        if (!state.isConfirmPassword && state.error.isNotEmpty) {
          showCustomSnackbar(context, message: state.error, isError: true);
        }
      },
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColours.white,
            appBar: widget.isAdmin
                ? const GlintEventAuthAppbar()
                : AppBar(backgroundColor: AppColours.white),
            body: state.isLoading
                ? Center(
                    child: Column(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          state.currentSuccessStatus,
                          style: AppTheme.headingThree,
                        )
                      ],
                    ),
                  )
                : AuthStackedIllustrationScreen(
                    isAdmin: widget.isAdmin,
                    body: Column(
                      children: [
                        if (!widget.isAdmin)
                          Center(
                            child: SvgPicture.asset(
                                'lib/assets/images/auth/glint_create_account.svg'),
                          ),
                        const Gap(40.0),
                        if (widget.isAdmin)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Column(
                                children: [
                                  const Spacer(),
                                  Text(
                                    'Create Account',
                                    style: AppTheme.headingThree.copyWith(
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  const Gap(32.0),
                                  _buildTextField(
                                    controller: _nameController,
                                    type: IconTextFieldType.user,
                                    focusNode: _nameFocusNode,
                                    hintText: 'Enter Your Name',
                                  ),
                                  const Gap(20.0),
                                  _buildTextField(
                                    controller: _emailController,
                                    type: IconTextFieldType.email,
                                    focusNode: _emailFocusNode,
                                    hintText: 'Enter Email',
                                  ),
                                  const Gap(20.0),
                                  _buildTextField(
                                    controller: _organizationController,
                                    type: IconTextFieldType.organization,
                                    focusNode: _organizationFocusNode,
                                    hintText:
                                        'Organization (ex: Hotel Vistara)',
                                  ),
                                  const Gap(20.0),
                                  _buildTextField(
                                    controller: _contactController,
                                    type: IconTextFieldType.contact,
                                    focusNode: _contactFocusNode,
                                    hintText: 'Contact Number',
                                  ),
                                  const Gap(20.0),
                                  _buildTextField(
                                    controller: _passwordController,
                                    type: IconTextFieldType.password,
                                    focusNode: _passwordFocusNode,
                                    hintText: 'Create Password',
                                  ),
                                  const Gap(48.0),
                                  GlintAuthActionButton(
                                    label: 'Register',
                                    onPressed: () {
                                      context
                                          .read<RegisterCubit>()
                                          .registerAsAAdmin();
                                      debugPrint(
                                        'Admin register button pressed',
                                      );
                                    },
                                  ),
                                  const Gap(16.0),
                                  _buildLoginText(),
                                  const Spacer(
                                    flex: 4,
                                  )
                                ],
                              ),
                            ),
                          ),
                        if (!widget.isAdmin) ...[
                          _buildTextField(
                            controller: _emailController,
                            type: IconTextFieldType.email,
                            focusNode: _emailFocusNode,
                            hintText: 'Enter Email',
                          ),
                          const Gap(20.0),
                          _buildTextField(
                            controller: _passwordController,
                            type: IconTextFieldType.password,
                            focusNode: _passwordFocusNode,
                            hintText: 'Create Password',
                          ),
                          const Gap(20.0),
                          _buildTextField(
                            controller: _confirmPasswordController,
                            type: IconTextFieldType.password,
                            focusNode: _confirmPasswordFocusNode,
                            hintText: 'Confirm Password',
                          ),
                          const Gap(60.0),
                          GlintAuthActionButton(
                            label: 'Sign up',
                            onPressed: () {
                              context.read<RegisterCubit>().registerUser();
                            },
                          ),
                          const Gap(16.0),
                          _buildLoginText(),
                        ],
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}
