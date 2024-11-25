import 'dart:async';

class Company {
  final String? branchName = "Colombo";
  final String companyName = "ABC Cab Servive";
  final String Owner = "Mr.Ranga";
  final double _rateperKillometter = 12.0;

  Company() {}
  void Welcome() {
    print("""
-------------------------------------------------------------------------------
                      2024 Welcome to $companyName $branchName 
--------------------------------------------------------------------------------\n""");
  }
}

// 'PS F:\Programming\dartOOPLearn> git pull origin [ranga]
// fatal: invalid refspec '[ranga]

class Trip extends Company {
  String? driverID;
  String? fromLocation;
  String? toLocation;
  String? passengerName;
  int tripCount = 0;
  double Distance = 0;
  String? DriverName;
  Car car;

  Trip(
      {required this.driverID,
      required this.Distance,
      required this.passengerName,
      required this.car,
      this.fromLocation,
      this.toLocation,
      this.DriverName});

  void printReciept() {
    print("""
---------------------------
  Welcome To $companyName 
---------------------------
Your Travel Distance :$Distance
From: $fromLocation to $toLocation
Your travel charge Is :${Distance * _rateperKillometter} Rs 
Driver name :$DriverName
passenger Name:$passengerName
Have a Nice day
Trip no: ${DateTime.now().day + tripCount}
Date ${DateTime.now()}""");
    tripCount += 1;
  }

  void startTrip() {
    print("""Hi $passengerName ! Trip is about to start...
    Driver name: $DriverName
    From Location: $fromLocation
    To Location : $toLocation
    Distance :$Distance
    """);
  }

  Future<void> startCountdown(int counter) async {
    while (counter > 0) {
      print("Running.......$counter");
      await Future.delayed(Duration(seconds: 2)); // Wait for 6 seconds
      counter--;
    }
  }

  void endTrip() {
    print("""
Your Trip is over.... please pay the bill
Have a nice >>>>>>>>>>>>>>>>>>>>>>>>>>>> !
 
""");
  }
}

class Car extends Company {
  String? brand;
  String? model;
  int? year;
  double _fuelLevel;
  int _RuningperLiter;
  double _fuelStock = 0;
  double _tankCapacity = 30;

  Car({
    String? driverId,
    required this.brand,
    required this.model,
    required this.year,
    required double fuelLevel,
    required int RuningperLiter,
    required double tankCapacity,
  })  : _fuelLevel = fuelLevel,
        _RuningperLiter = RuningperLiter,
        _tankCapacity = tankCapacity {
    // Calling displayCarinfo() within the constructor
  }

  double getFuelLevel() {
    return _fuelLevel;
  }

  void displayCarinfo() {
    print("""Car Brand:$brand model:$model year:$year
    Fuel Level :${_fuelLevel}
    Fuel Stock :$_fuelStock
    Fuel Consumption:$_RuningperLiter
    Tank capacity :$_tankCapacity
    Runing  capability on fuel : ${(_fuelLevel + _fuelStock) * _RuningperLiter} KM\n""");
  }

  dynamic refill({required refillAmount}) {
    if (refillAmount <= 0) {
      print("Error in Fuel pump");
    } else if (_fuelLevel <= _tankCapacity &&
        !(refillAmount + _fuelLevel >= _tankCapacity)) {
      _fuelLevel += refillAmount;

      print(""" Refilled....$refillAmount Liters Fuel Level: ${_fuelLevel}""");
    } else if ((refillAmount + _fuelLevel) >= _tankCapacity) {
      var emptySpace = _tankCapacity - _fuelLevel;
      _fuelStock = refillAmount - emptySpace;

      print("""dude! Tank capacity is 30 liters 
      $emptySpace Liters were filled and $_fuelStock Liters Stored """);
    }
  }

  void drive({required double routeDistance}) {
    if ((routeDistance / _RuningperLiter) <= (_fuelLevel + _fuelStock)) {
      print("""

Checking fuel level         >>>> $_fuelLevel Fuel Stock :$_fuelStock
Runnable distance on fuel   >>>> ${(_fuelLevel + _fuelStock) * _RuningperLiter} Km
Here We Go...
Engine Started...\n
    """);
      var counter = 5;
      while (counter > 0) {
        print("Running.......$counter");
        Future.delayed(Duration(seconds: 6)); // Wait for 6 seconds
        counter--;
      }
    } else {
      print("""
You Don't have Enough fuel to Complete this Trip please refill Your Car
Distance to travel: ${routeDistance.toStringAsFixed(2)} KM
Required fuel : ${routeDistance / _RuningperLiter} Liters
Available : ${_fuelStock + _fuelLevel} Liters\n""");
    }
  }
}

void main(List<String> args) async {
  Company company = Company();
  company.Welcome();

  Car car0 = Car(
      brand: "Toyota",
      model: "Prius",
      year: 2014,
      fuelLevel: 18,
      RuningperLiter: 25,
      tankCapacity: 30);

  Trip trip = Trip(
      driverID: "DR001",
      Distance: 27,
      passengerName: "john peterson",
      car: car0,
      fromLocation: "Nittabuwa",
      toLocation: "kotmale",
      DriverName: "Richard samuel");

  trip.startTrip();
  trip.car.displayCarinfo();
  trip.car.refill(refillAmount: 4);
  trip.car.drive(routeDistance: 47);
  await trip.startCountdown(5);
  trip.endTrip();
  trip.printReciept();
}
