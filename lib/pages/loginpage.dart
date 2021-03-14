import 'package:flutter/material.dart';
import 'package:http_login_app/api/apiservice.dart';
import 'package:http_login_app/model/loginmodel.dart';
import 'package:http_login_app/utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalKeyFormKey = new GlobalKey<FormState>();
  bool hidePass = true;

  LoginRequestModel requestModel;
  bool isApiCallProcess  = false;


  @override
  void initState() {
    requestModel = new LoginRequestModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
  return ProgressHUD(child: _uiSetup(context),inAsyncCall: isApiCallProcess,opacity: 0.3,);
  }

  @override
  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      key: scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20.0),
                        ]),
                    child: Form(
                        key: globalKeyFormKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 25,
                            ),
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            new TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (input)=> requestModel.email = input,
                              validator: (input) => !input.contains("@")
                                  ? "Email Id should be valid"
                                  : null,
                              decoration: new InputDecoration(
                                  hintText: "Email Address",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor)),
                                  prefixIcon: Icon(Icons.email,color: Theme.of(context).accentColor,)),
                            ),

                            SizedBox(height: 20.0,),
                            new TextFormField(
                              keyboardType: TextInputType.text,
                              onSaved: (input) => requestModel.password = input,
                              validator: (input) => input.length<3
                                  ? "Password should be more than 3 characters"
                                  : null,
                              obscureText: hidePass,
                              decoration: new InputDecoration(
                                  hintText: "Password",
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor)),
                                  prefixIcon: Icon(Icons.lock,color: Theme.of(context).accentColor,),
                                  suffixIcon: IconButton(
                                    onPressed: (){
                                      setState(() {
                                        hidePass =!hidePass;
                                      });
                                    },
                                    color: Theme.of(context).accentColor.withOpacity(0.7)
                                    ,icon: Icon(hidePass ? Icons.visibility_off: Icons.visibility),
                                  )),

                            ),
                            SizedBox(height: 30,),
                            FlatButton(
                              padding: EdgeInsets.symmetric(vertical: 12.0,horizontal: 80.0),
                              onPressed: (){
                                if(validateAndSave()){
                                  setState(() {
                                    isApiCallProcess = true;
                                  });

                                  APIService apiService =new APIService();
                                  apiService.login(requestModel).then((value){
                                  setState(() {
                                  isApiCallProcess = false;
                                  });

                                  if(value.token.isNotEmpty){
                                    final snackbar = SnackBar(
                                      content: Text(
                                        "Login Successful",
                                      ),
                                    );
                                    scaffoldKey.currentState.showSnackBar(snackbar);

                                  }else{
                                    final snackbar = SnackBar(
                                      content: Text(
                                        value.error,
                                      ),
                                    );
                                    scaffoldKey.currentState.showSnackBar(snackbar);

                                  }
                                  });
                                  print(requestModel.toJson());
                                }

                              },
                              child: Text("Login",style: TextStyle(color: Colors.white),),
                              color: Theme.of(context).accentColor,
                              shape: StadiumBorder(),
                            )

                          ],
                        )),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validateAndSave (){
    final form = globalKeyFormKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
}
