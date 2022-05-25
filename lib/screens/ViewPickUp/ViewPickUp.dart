import 'package:bike_junction_customer/screens/Dashboard/contract/GetPickUpContract.dart';
import 'package:bike_junction_customer/screens/Dashboard/model/GetPickupDataModel.dart';
import 'package:bike_junction_customer/utils/FetchException.dart';
import 'package:bike_junction_customer/utils/MyColors.dart';
import 'package:cupertino_stepper/cupertino_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPickUp extends StatefulWidget {
  final GetPickupData getPickupData;

  const ViewPickUp({Key? key, required this.getPickupData}) : super(key: key);

  @override
  _ViewPickUpState createState() => _ViewPickUpState();
}

class _ViewPickUpState extends State<ViewPickUp> {
  int currentStep = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: MyColors.screen_background,
      navigationBar: CupertinoNavigationBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: MyColors.white,
            )),
        backgroundColor: MyColors.app_theme_color,
        middle: Text(
          'Current Job view',
          style: TextStyle(color: MyColors.white),
        ),
      ),
      child: SafeArea(
        child: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            switch (orientation) {
              case Orientation.portrait:
                return _newBookedCard();
              // return _buildStepper(StepperType.vertical);
              case Orientation.landscape:
                return _newBookedCard();

              //return _buildStepper(StepperType.horizontal);
              default:
                throw UnimplementedError(orientation.toString());
            }
          },
        ),
      ),
    );
  }

  Widget _newBookedCard() {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16),
      child: bookedPickCard(widget.getPickupData),
    );
  }

  Widget _buildStepper(StepperType type) {
    return CupertinoStepper(
      type: type,
      currentStep: currentStep,
      onStepTapped: (step) {
        setState(() {
          currentStep = step;
          print(currentStep);
        });
      },
      steps: [
        Step(
            title: Text("Booked Pickup"),
            subtitle: Text(''),
            state: currentStep == 0 ? StepState.complete : StepState.indexed,
            isActive: true,
            content: bookedPickCard(widget.getPickupData)),
        Step(
            title: Text("Picked Up"),
            subtitle: Text(''),
            state: currentStep == 1 ? StepState.complete : StepState.indexed,
            isActive: true,
            content: pickUpCard("Karan")),
        Step(
            title: Text("Reached to Center"),
            subtitle: Text(''),
            state: currentStep == 2 ? StepState.complete : StepState.indexed,
            isActive: true,
            content: reachedToCenter("BikeJunction")),
        Step(
            title: Text("Service in progress"),
            subtitle: Text(''),
            state: currentStep == 3 ? StepState.complete : StepState.indexed,
            isActive: true,
            content: serviceInProgressCard()),
        Step(
            title: Text("Service Completed"),
            subtitle: Text(''),
            state: currentStep == 4 ? StepState.complete : StepState.indexed,
            isActive: true,
            content: serviceCompletedCard("1000")),
      ],
    );
  }

  Widget bookedPickCard(GetPickupData getData) {
    return Card(
      color: MyColors.screen_background,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Vehicle Name :",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupBikemodel!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Vehicle Number :",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupBikenumber!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Pickup :",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupAddress!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Pickup Date :",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupDate!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Services :",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupServices!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Problems :",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupIssues!,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    "Status:",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: MyColors.black,
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    getData.pickupStatus!,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: getData.pickupStatus == "Done"
                          ? MyColors.creamGreen
                          : MyColors.red,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget pickUpCard(String pickedByName) {
    return Card(
      color: MyColors.screen_background,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Picked By :",
                style: TextStyle(
                  fontSize: 14.0,
                  color: MyColors.black,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                pickedByName,
                style: TextStyle(
                  fontSize: 14.0,
                  color: MyColors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget reachedToCenter(String centerName) {
    return Card(
      color: MyColors.screen_background,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Vehicle is reached to center $centerName",
                style: TextStyle(
                  fontSize: 14.0,
                  color: MyColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceInProgressCard() {
    return Card(
      color: MyColors.screen_background,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Service in progress, please wait...!",
                style: TextStyle(
                  fontSize: 14.0,
                  color: MyColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget serviceCompletedCard(String serviceAmount) {
    return Card(
      color: MyColors.screen_background,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Service is completed, your final service amount is $serviceAmount",
                style: TextStyle(
                  fontSize: 14.0,
                  color: MyColors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainBody() {
    return Column(
      children: [],
    );
  }
}
