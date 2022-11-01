import 'package:ecom_admin_3/auth/auth_service.dart';
import 'package:ecom_admin_3/pages/launcher_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  static const String routeName="/login_page";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey=GlobalKey<FormState>();
  final _emailController=TextEditingController();
  final _passwordController=TextEditingController();
  String _errMsg='';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration:const InputDecoration(
                  labelText: 'Email Address',
                  prefixIcon: Icon(Icons.email),
                  filled: true,
                ) ,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Please fill up email field";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _passwordController,
                obscureText: true,
                decoration:const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                ) ,
                validator: (value){
                  if(value==null || value.isEmpty){
                    return "Please fill up password field";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){
                    _authenticate();
                  },
                  child: const Text("Login As Admin")
              ),
              const SizedBox(height: 10,),
              Text(_errMsg,style:const TextStyle(fontSize: 20,color: Colors.red),)
            ],
          ),
        ),
      ),
    ),
    );
  }

  void _authenticate()async {
    if(_formKey.currentState!.validate()){
      EasyLoading.show(status: 'please wait',dismissOnTap: false);
      final email=_emailController.text;
      final password=_passwordController.text;
      try{
        final status=await AuthService.loginAdmin(email,password);
        EasyLoading.dismiss();
        if(status){
          if(mounted){
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        }else{
          await AuthService.logOut();
          setState(() {
            _errMsg= "yor are not a admin";
          });
        }


      }on FirebaseAuthException catch (error){
        EasyLoading.dismiss();
        setState(() {
          _errMsg=error.message!;
        });
      }
    }
  }

}
