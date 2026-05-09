import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nti5/auth/cubit/auth_cubit.dart';
import 'package:nti5/auth/cubit/auth_state.dart';
import 'package:nti5/auth/widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/small_logo.png',
              width: size.width * 0.1,
              height: size.width * 0.1,
            ),
            SizedBox(width: size.width * 0.02),
            Text(
              'MEDI CALL',
              style: TextStyle(
                fontSize: size.width * 0.05,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Account Created")));

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pushReplacementNamed(context, '/login');
            });
          }

          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },

        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.all(size.width * 0.06),

              child: SingleChildScrollView(
                child: Form(
                  key: formKey,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create your account',
                        style: TextStyle(
                          fontSize: size.width * 0.08,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: size.height * 0.015),

                      Text(
                        'Join the MEDI CALL community and manage your healthcare journey with ease and efficiency.',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: size.width * 0.035,
                        ),
                      ),

                      SizedBox(height: size.height * 0.04),

                      // NAME
                      Text(
                        'Full Name',
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                      SizedBox(height: size.height * 0.01),

                      CustomTextFormField(
                        hint: 'Enter your full name',
                        controller: nameController,
                        prefixIcon: Icons.person_outline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: size.height * 0.02),

                      // EMAIL
                      Text(
                        'Email Address',
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                      SizedBox(height: size.height * 0.01),

                      CustomTextFormField(
                        hint: 'name@example.com',
                        controller: emailController,
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: size.height * 0.02),

                      // PASSWORD
                      Text(
                        'Password',
                        style: TextStyle(fontSize: size.width * 0.04),
                      ),
                      SizedBox(height: size.height * 0.01),

                      CustomTextFormField(
                        hint: 'Create a secure password',
                        controller: passwordController,
                        prefixIcon: Icons.lock_outline,
                        obscure: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: size.height * 0.03),

                      // BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: size.height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),

                          onPressed: state is AuthLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().signUp(
                                      emailController.text,
                                      passwordController.text,
                                      nameController.text,
                                    );
                                  }
                                },

                          child: state is AuthLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.045,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.03),

                      Center(
                        child: Text(
                          'OR SIGN UP WITH',
                          style: TextStyle(fontSize: size.width * 0.035),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.g_mobiledata),
                              label: Text(
                                'Google',
                                style: TextStyle(fontSize: size.width * 0.035),
                              ),
                            ),
                          ),
                          SizedBox(width: size.width * 0.04),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                              ),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.apple,
                                color: Colors.white,
                              ),
                              label: Text(
                                'Apple',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.035,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.03),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Already have an account? '),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.04,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: size.height * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

