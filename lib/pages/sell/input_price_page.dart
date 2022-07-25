import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:terminal_app/component/colors.dart';
import 'package:terminal_app/controllers/app_controller.dart';
import 'package:terminal_app/routes/routes.dart';
import 'package:terminal_app/widget/show_custom_message.dart';


class InputPriceScreen extends StatefulWidget {
  const InputPriceScreen({Key? key}) : super(key: key);

  @override
  State<InputPriceScreen> createState() => _InputPriceScreenState();
}

class _InputPriceScreenState extends State<InputPriceScreen> {
  final _formKey = GlobalKey<FormState>();
  var _amountController = TextEditingController();
  String selectedCategories = "PMS";
  List<String> categoriesController = Get.find<DailyTransactionController>().productCategories;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: appWhite,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          margin: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
             Container(
                height: 60,
                width: width,
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: (){
                    Get.offAllNamed(RoutesClass.getHomeRoute());
                  },
                  child: Card(
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 4,
                    color: appLightBg,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                    ),
                    child: const SizedBox(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.arrow_back, size: 30, color: appWhite,)),
                  ),
                ),
              ),
              const SizedBox(height: 25,),
              const Text("Product Type", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: appTextPrimary
              ),),
              const SizedBox(height: 10,),
              DropdownButtonFormField<String>(
                decoration: const  InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appDeepBg)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appTextSecondary)),
                ),
                value: selectedCategories,
                items: categoriesController.map((e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(e, style: const TextStyle(fontSize: 16),)
                )).toList(),
                onChanged: (e)=> setState(()=> selectedCategories = e!),
              ),
              const SizedBox(height: 20,),
              const Text("Enter Amount", style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: appTextPrimary
              ),),
              const SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _amountController,
                decoration: const  InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: appDeepBg)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appTextSecondary)),
                  labelText: "Amount",
                  labelStyle: TextStyle(color: appTextSecondary, fontSize: 14),
                ),
              ),
              const SizedBox(height: 25,),
              ElevatedButton(onPressed: (){
                _nextPage();
              },
                style: ElevatedButton.styleFrom(
                    primary: appDeepBg,
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5), bottomRight: Radius.circular(5))
                    )
                ),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.all(20),
                  child: const Text("Next", textAlign: TextAlign.center, style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),),
                ),),
            ],
          ),
        ),
      ),
    );

  }
  _nextPage(){
    String category = selectedCategories;
    String inputAmount = _amountController.text.trim();
    if(category.isEmpty){
      showCustomSnackBar("Select a category", title: "Category field error");
    }else if(inputAmount.isEmpty){
      showCustomSnackBar("Enter a valid amount", title: "Amount field error");
    }else if(int.parse(inputAmount) < 0){
      showCustomSnackBar("Please enter a positive integer", title: "Type error");
    }else{
      Get.toNamed(RoutesClass.getScanPage(category, inputAmount));
    }
  }
}
