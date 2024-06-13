import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pangyangjourney/features/authentication/screens/login/login/widgets/login_form.dart';
import 'package:pangyangjourney/features/authentication/screens/login/login/widgets/login_headers.dart';
import 'package:pangyangjourney/features/feature/screens/home/home.dart';



import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../../common/styles/spacing_styles.dart';
import '../../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../../common/widgets/login_signup/social_button.dart';
import '../../../../../utils/constants/sizes.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key); // Add the key parameter

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo, Title, and Sub-Title
              const TLoginHeader(),

              ///Form
              LoginForm(onLoginSuccess: (username) {
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context) => HomeScreen(username: username),));
              }), // Corrected the constructor call

              ///Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              ///Footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}


// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: TSpacingStyle.paddingWithAppBarHeight,
//           child: Column(
//             children: [
//               ///Logo, Title, and Sub-Title
//               const TLoginHeader(),

//               ///Form
//               const TLoginForm(),

//               ///Divider
//               TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
//               const SizedBox(height: TSizes.spaceBtwSections),


//               ///Footer
//               const TSocialButtons(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
