import 'dart:io';

import 'package:bike_junction_customer/screens/AddPickUp/contract/AddPickUpContract.dart';
import 'package:bike_junction_customer/screens/AddPickUp/contract/AllBranchContract.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/AddPickUpModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/AllBranchModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetAllBrandsModel.dart';
import 'package:bike_junction_customer/screens/AddPickUp/model/GetModelName.dart';
import 'package:bike_junction_customer/screens/AddPickUp/presenter/AddPickUpPresenter.dart';
import 'package:bike_junction_customer/screens/AddPickUp/presenter/AllBranchPresenter.dart';
import 'package:bike_junction_customer/utils/CheckConnection.dart';
import 'package:bike_junction_customer/utils/Converter.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/ImageViewPage.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:bike_junction_customer/utils/Toast.dart';
import 'package:bike_junction_customer/utils/sharedPreference/SharedPreference.dart';
import 'package:bike_junction_customer/utils/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddPickUpPage extends StatefulWidget {
  const AddPickUpPage({Key? key}) : super(key: key);

  @override
  _AddPickUpPageState createState() => _AddPickUpPageState();
}

class _AddPickUpPageState extends State<AddPickUpPage>
    implements AllBranchContract, AddPickUpContract {
  //TextEditingController bikeNameController = TextEditingController();
  TextEditingController bikeNumberController = TextEditingController();
  TextEditingController addressToPickController = TextEditingController();
  TextEditingController pickUpTimeDateController = TextEditingController();
  TextEditingController servicesController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  TextEditingController selectBranchController = TextEditingController();

  //TextEditingController bikeBrandController = TextEditingController();

  late List<String> files;
  late List<String> base64List;
  bool isFileSelect = false;
  bool isCamera = false;
  late List<File> cameraList = [];
  late final imagePicker = ImagePicker();
  late File _image;

  bool isLoading = false;
  late CheckInternet checkInternet;
  var selectedBranchId;
  var selectedBranchName;
  var selectedBrandName;
  var selectedModelName;
  late AllBranchPresenter allBranchPresenter;
  late List<AllBranchData> allBranchList;
  late List<AllBrandData> allBrandModel;
  late List<ModelData> allModelName;
  late String sYear;

  late String sMonth;
  late String sDate;
  late String sHour;
  late String sMinute;
  late String finalEndDate;
  late String finalEndTime;
  bool isValidBikeName = false;
  bool isValidBikeNumber = false;
  bool isValidPickUpDateTime = false;
  bool isValidBikePickUpAddr = false;
  bool isValidBikeProblems = false;
  bool isValidBikeServices = false;
  bool isValidBikeBranchName = false;
  bool isValidBikeDentImages = false;
  bool isBranchSelected = false;
  bool isBikeBrandValid = false;
  var selectedImgExtension;
  late AddPickUpPresenter addPickUpPresenter;
  late String selectedBrand;
  late String selectedModel;

  _AddPickUpPageState() {
    allBranchPresenter = AllBranchPresenter(this);
    addPickUpPresenter = AddPickUpPresenter(this);
  }

  late AddPickUpRequestModel addPickUpRequestModel;

  addPickUp() {
    setState(() {
      isLoading = true;
    });
    addPickUpRequestModel = AddPickUpRequestModel();
    addPickUpRequestModel.user_id = SharedPreference.getCustomerId().toString();
    addPickUpRequestModel.branchId = selectedBranchId;
    addPickUpRequestModel.name = SharedPreference.getCustomerName();
    addPickUpRequestModel.bikenumber = bikeNumberController.text;
    addPickUpRequestModel.address = addressToPickController.text;
    addPickUpRequestModel.bikebrand = selectedBrand;
    addPickUpRequestModel.bikemodel = selectedModel;
    addPickUpRequestModel.date = finalEndDate;
    addPickUpRequestModel.time = finalEndTime;
    addPickUpRequestModel.issues = problemController.text;
    addPickUpRequestModel.services = servicesController.text;
    addPickUpRequestModel.images = base64List;
    addPickUpRequestModel.status = "0";
    addPickUpRequestModel.mobileno = SharedPreference.getCustomerMobile();
    addPickUpPresenter.addPickUp(addPickUpRequestModel, 'putpickup');
  }

  getAllBranch() {
    setState(() {
      isLoading = true;
    });
    allBranchPresenter.getAllBranches('getallbranch');
  }

  getBrand() {
    addPickUpPresenter.getBrand('getAllBrand');
  }

  getModelName(int brandId) {
    addPickUpPresenter.getBrandModel('getBrandModels/$brandId');
  }

  checkConnection() {
    allBranchList.clear();
    checkInternet.check().then((value) {
      if (value) {
        getBrand();
        getAllBranch();
      } else {
        // DialogHelper.noInternet(
        //     context,
        //     MyAssets.noInternetIcon,
        //     MyStrings.btn_retry,
        //     MyStrings.btn_cancel,
        //     onClickRetry,
        //     onClickCancel);
      }
    });
  }

  validateData() {
    selectedModel.isEmpty ? isValidBikeName = true : isValidBikeName = false;

    bikeNumberController.text.isEmpty
        ? isValidBikeNumber = true
        : isValidBikeNumber = false;

    addressToPickController.text.isEmpty
        ? isValidBikePickUpAddr = true
        : isValidBikePickUpAddr = false;

    selectedModel.isEmpty ? isValidBikeName = true : isValidBikeName = false;

    pickUpTimeDateController.text.isEmpty
        ? isValidPickUpDateTime = true
        : isValidPickUpDateTime = false;

    problemController.text.isEmpty
        ? isValidBikeProblems = true
        : isValidBikeProblems = false;

    servicesController.text.isEmpty
        ? isValidBikeServices = true
        : isValidBikeServices = false;

    selectedBrand.isEmpty ? isBikeBrandValid = true : isBikeBrandValid = false;

    if (selectedModel.isEmpty) {
      setState(() {
        isValidBikeName = true;
        ShowMessage().showToast("Enter bike model");
      });
      isValidBikeName = false;
    }

    if (selectedBrand.isEmpty) {
      setState(() {
        isBikeBrandValid = true;
        ShowMessage().showToast("Enter bike brand");
      });
      isBikeBrandValid = false;
    }

    if (bikeNumberController.text.isEmpty) {
      setState(() {
        isValidBikeNumber = true;
        ShowMessage().showToast("Enter bike number");
      });
      isValidBikeNumber = false;
    }

    if (addressToPickController.text.isEmpty) {
      setState(() {
        isValidBikePickUpAddr = true;
        ShowMessage().showToast("Enter pickup address");
      });
      isValidBikePickUpAddr = false;
    }

    if (pickUpTimeDateController.text.isEmpty) {
      setState(() {
        isValidPickUpDateTime = true;
        ShowMessage().showToast("Select pickup date and time");
      });
      isValidPickUpDateTime = false;
    }

    if (problemController.text.isEmpty) {
      setState(() {
        isValidBikeProblems = true;
        ShowMessage().showToast("Enter bike problems");
      });
      isValidBikeProblems = false;
    }

    if (servicesController.text.isEmpty) {
      setState(() {
        isValidBikeServices = true;
        ShowMessage().showToast("Enter bike services");
      });
      isValidBikeServices = false;
    }

    if (isFileSelect == false) {
      ShowMessage().showToast("select images");
    }

    // if(isValidBikeName == false &&  isValidBikeNumber == false && isValidBikePickUpAddr == false &&
    // isValidBikeServices == false && isValidBikeProblems == false && isValidPickUpDateTime == false && isFileSelect == true
    // && isBranchSelected == true){
    //
    //
    // }
    addPickUp();
    print("valid data");
  }

  Future captureImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    print("path: ${_image.path}");
    var fileName = (pickedFile?.path.split('/').last);

    print(fileName);
    //print(filePath);
    setState(() {
      isFileSelect = true;
      selectedImgExtension = fileName!.split(".")[1];
      _image = File(pickedFile!.path);
      print("path: ${_image.path}");
    });
    var base64ImageExtension =
        " $selectedImgExtension,${Converter.convertIntoBase64(_image)}";
    addImageIntoList(_image, base64ImageExtension);
  }

  Future pickImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    var fileName = (pickedFile!.path.split('/').last);
    print(fileName);
    setState(() {
      selectedImgExtension = fileName.split(".")[1];
      isFileSelect = true;
      _image = File(pickedFile.path);
    });
    var base64ImageExtension =
        "$selectedImgExtension,${Converter.convertIntoBase64(_image)}";
    addImageIntoList(_image, base64ImageExtension);
  }

  addImageIntoList(File image, String base64) {
    // if (cameraList.length == 2) {
    //   cameraList = [];
    //   base64List = [];
    //   setState(() {
    //     cameraList.add(image);
    //     base64List.add(base64);
    //   });
    // } else {
    setState(() {
      cameraList.add(image);
      base64List.add(base64);
    });
    // }
  }

  @override
  void initState() {
    super.initState();
    allBranchList = [];
    allBrandModel = [];
    allModelName = [];

    SharedPreference.init();
    checkInternet = CheckInternet();
    checkConnection();
    base64List = [];
    print(SharedPreference.getBranchId());
    _image = File("");
    setPickupAddress();
  }

  void setPickupAddress() async {
    Position position = await _getGeoLocationPosition();
    String location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    GetAddressFromLatLong(position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.app_theme_color,
        title: Row(
          children: [
            Text(
              "Add Pickup",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
        // leading: Icon(Icons.person),
      ),
      body: SafeArea(
        child: isLoading
            ? ShimmerWidget()
            : LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: Container(
                    //height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    color: MyColors.screen_background,
                    child: Column(
                      children: [
                        mainBody(),
                        SizedBox(
                          height: 80,
                        )
                      ],
                    ),
                  ),
                );
              }),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: GestureDetector(
          onTap: () {
            validateData();
            print("clicked");
            //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> DashboardPage()));
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: MyColors.app_theme_color,
            child: Center(
              child: Text(
                "Submit",
                style: TextStyle(fontSize: 16, color: MyColors.white),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget mainBody() {
    final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.electric_bike,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: DropdownButton<AllBrandData>(
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 5),
                        child: Text("Bike Brand"),
                      ),
                      isDense: false,
                      underline: SizedBox(),
                      isExpanded: true,
                      // menuMaxHeight: 50,
                      items: allBrandModel.map((AllBrandData index) {
                        return DropdownMenuItem<AllBrandData>(
                            value: index,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Text(index.branchId!),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 8, top: 8),
                                  child: Text(
                                    "${index.brandName}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedBrandName = newValue!;
                          String selectedBrandId = newValue.id!;
                          print(selectedBrandId);
                          selectedModelName = null;
                          allModelName = [];
                          selectedBrand = newValue.brandName!;
                          getModelName(int.parse(selectedBrandId));
                        });
                      },
                      value: selectedBrandName,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              margin: EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      width: 24,
                      height: 24,
                      margin: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.electric_bike,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: DropdownButton<ModelData>(
                      hint: Padding(
                        padding:
                            const EdgeInsets.only(left: 16, right: 8, top: 8),
                        child: Text("Bike Model"),
                      ),
                      isDense: false,
                      underline: SizedBox(),
                      isExpanded: true,
                      // menuMaxHeight: 50,
                      items: allModelName.map((ModelData index) {
                        return DropdownMenuItem<ModelData>(
                            value: index,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Text(index.branchId!),
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 16, right: 8, top: 8),
                                  child: Text(
                                    "${index.vehicleModel}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                )
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedModel = newValue!.vehicleModel!;

                          selectedModelName = newValue;
                        });
                      },
                      value: selectedModelName,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 80,
              child: TextField(
                controller: bikeNumberController,
                textCapitalization: TextCapitalization.characters,
                autocorrect: false,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')),
                ],
                decoration: new InputDecoration(
                  errorText: isValidBikeNumber ? "Enter bike number" : null,
                  border: new OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: MyColors.app_theme_color)),
                  hintText: 'Number',
                  labelText: 'Number',
                  prefixIcon: const Icon(
                    Icons.electric_bike,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: TextField(
                controller: addressToPickController,
                decoration: new InputDecoration(
                  errorText:
                      isValidBikePickUpAddr ? "Enter pickup address" : null,
                  border: new OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: MyColors.app_theme_color)),
                  hintText: 'Pickup address',
                  labelText: 'Pickup address',
                  prefixIcon: const Icon(
                    Icons.add_location_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _selectDateAndTime(context);
              },
              child: Container(
                height: 80,
                child: TextField(
                  controller: pickUpTimeDateController,
                  decoration: new InputDecoration(
                    disabledBorder: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: MyColors.app_theme_color)),
                    border: new OutlineInputBorder(
                        borderSide:
                            new BorderSide(color: MyColors.app_theme_color)),
                    hintText: 'Pick up date and time',
                    enabled: false,
                    labelText: 'Pick up date and time',
                    prefixIcon: const Icon(
                      Icons.date_range,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: TextField(
                controller: problemController,
                decoration: new InputDecoration(
                  errorText: isValidBikeProblems ? "Enter problems" : null,
                  border: new OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: MyColors.app_theme_color)),
                  hintText: 'Problems',
                  labelText: 'Problems',
                  prefixIcon: const Icon(
                    Icons.sentiment_very_dissatisfied_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 80,
              child: TextField(
                controller: servicesController,
                decoration: new InputDecoration(
                  errorText: isValidBikeServices ? "Enter services" : null,
                  border: new OutlineInputBorder(
                      borderSide:
                          new BorderSide(color: MyColors.app_theme_color)),
                  hintText: 'Services',
                  labelText: 'Services',
                  prefixIcon: const Icon(
                    Icons.miscellaneous_services_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
              width: MediaQuery.of(context).size.width,
              child: DropdownButton<AllBranchData>(
                hint: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 5),
                  child: Text("Select branch"),
                ),
                isDense: false,
                underline: SizedBox(),
                isExpanded: true,
                // menuMaxHeight: 50,
                items: allBranchList.map((AllBranchData index) {
                  return DropdownMenuItem<AllBranchData>(
                      value: index,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //Text(index.branchId!),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 16, right: 8, top: 8),
                            child: Text(
                              "${index.branchName}",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ));
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    isBranchSelected = true;
                    selectedBranchName = newValue;
                    selectedBranchId = newValue!.branchId;
                    print(selectedBranchId);
                    print(selectedBranchName);
                  });
                },
                value: selectedBranchName,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Please select/capture dent images",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: Container(
                height: 150.0,
                width: 150.0,
                // color: MyColors.grey,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Icon(
                  Icons.camera_alt,
                  size: 48.0,
                  color: MyColors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Selected images are shown below",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            isFileSelect
                ? cameraList.isNotEmpty
                    ? GridView.builder(
                        itemCount: cameraList.length,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                (orientation == Orientation.portrait) ? 2 : 3),
                        itemBuilder: (BuildContext context, int index) {
                          return new Card(
                            child:
                                cameraGridViewWidget(cameraList[index], index),
                          );
                        },
                      )
                    : Container()
                : Padding(
                    padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Icon(
                          Icons.flip_camera_ios,
                          size: 60.0,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  Container(
                    color: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, top: 8.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Upload dent images",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white)),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text("Camera"),
                    onTap: () {
                      setState(() {
                        captureImage();
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text("Gallery"),
                      onTap: () {
                        pickImage();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  //image captured from camera
  Widget cameraGridViewWidget(File imageFile, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 140.0,
        height: 150.0,
        decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cameraList.removeAt(index);
                      base64List.removeAt(index);
                      cameraList.isEmpty
                          ? isFileSelect = false
                          : isFileSelect = true;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 10.0,
                    child: Icon(
                      Icons.close,
                      color: MyColors.white,
                      size: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            Hero(
              tag: "image $index",
              child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ImageViewPage(imageFile)));
                  },
                  child: Container(
                    width: 100.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: FileImage(imageFile),
                    )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text("Dent ${index + 1}"),
            )
          ],
        ),
      ),
    );
  }

  //Select Date
  _selectDateAndTime(BuildContext context) async {
    DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        theme: DatePickerTheme(backgroundColor: MyColors.white),
        minTime: DateTime.now(),
        maxTime: DateTime(2050, 6, 7), onConfirm: (dateTime) {
      setState(() {
        // String newDate = formatedDate.format(dateTime);
        // print(newDate);

        sYear = dateTime.year.toString();
        sMonth = dateTime.month.toString();
        sDate = dateTime.day.toString();
        sHour = dateTime.hour.toString();
        sMinute = dateTime.minute.toString();

        final DateFormat formatter = DateFormat('dd-MM-yy, hh:mm aa');
        String formatedDate = formatter.format(dateTime);

        finalEndDate = sYear + "-" + sMonth + "-" + sDate;
        finalEndTime = sHour + ":" + sMinute;

        pickUpTimeDateController.text = formatedDate;
        sHour = dateTime.hour.toString();
      });
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  @override
  void getAllBranchesFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void getAllBranchesSuccess(AllBranchResponseModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 1) {
      allBranchList.addAll(responseModel.data!);
      //allBranchList.removeAt(0);
      ShowMessage().showToast("Success");
    }
  }

  @override
  void addPickUpFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void addPickUpSuccess(AddPickUpResponseModel responseModel) {
    setState(() {
      isLoading = false;
    });
    if (responseModel.status == 1) {
      ShowMessage().showToast("Pickup added successfully");
      Navigator.pop(context, true);
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    String address = '${place.street}, ${place.subLocality}, ${place.locality},'
        ' ${place.postalCode}, '
        '${place.country}';
    print(address);

    setState(() {
      addressToPickController.text = place.locality.toString();
    });
  }

  @override
  void getBrandFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void getBrandModelFailure(FetchException exception) {
    setState(() {
      isLoading = false;
    });
    ShowMessage().showToast("Something went wrong");
  }

  @override
  void getBrandModelSuccess(GetModelName responseModel) {
    if (responseModel.status == 1) {
      setState(() {
        allModelName = List.from(allModelName)..addAll(responseModel.data!);
        //   allModelName.addAll(responseModel.data!);
      });
      ShowMessage().showToast("Success");
    }
  }

  @override
  void getBrandSuccess(GetAllBrandsModel responseModel) {
    if (responseModel.status == 1) {
      allBrandModel.addAll(responseModel.data!);
      ShowMessage().showToast("Success");
    }
  }
}
