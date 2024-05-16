import 'package:flutter/material.dart';

class TempPrefPage extends StatefulWidget {
  final Function(int newHot, int newWarm, int newModerate, int newCold) tempPrefFunction;
  final int currHot;
  final int currWarm;
  final int currModerate;
  final int currCold;

  const TempPrefPage({
    super.key,
    required this.tempPrefFunction,
    required this.currHot,
    required this.currWarm,
    required this.currModerate,
    required this.currCold
  });

  @override
  _TempPrefPageState createState() => _TempPrefPageState();
}

class _TempPrefPageState extends State<TempPrefPage> {
  late int hotTemp;
  late int warmTemp;
  late int moderateTemp;
  late int coldTemp;

  @override
  void initState() {
    super.initState();
    hotTemp = widget.currHot;
    warmTemp = widget.currWarm;
    moderateTemp = widget.currModerate;
    coldTemp = widget.currCold;
  }

  void _savePreferences() {
    widget.tempPrefFunction(hotTemp, warmTemp, moderateTemp, coldTemp);
    Navigator.pop(context);
  }

  List<DropdownMenuItem<int>> _generateItems(int minValue, int maxValue) {
    return List.generate(maxValue - minValue + 1, (index) => minValue + index)
        .map((int value) {
      return DropdownMenuItem<int>(
        value: value,
        child: Text(value.toString()),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _savePreferences,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const SizedBox(
                  width: 320,
                  child: Text(
                    'Temperature',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'SF Pro',
                      fontWeight: FontWeight.bold,
                      height: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                _buildTemperatureSetting('Hot', hotTemp, (value) {
                  setState(() {
                    hotTemp = value;
                  });
                }, minValue: warmTemp + 1, maxValue: 99, rangeText: '~ Above'),
                const SizedBox(height: 4),
                _buildTemperatureSetting('Warm', warmTemp, (value) {
                  setState(() {
                    warmTemp = value;
                  });
                }, minValue: moderateTemp + 1, maxValue: hotTemp - 1, rangeText: '~ $hotTemp'),
                const SizedBox(height: 4),
                _buildTemperatureSetting('Moderate', moderateTemp, (value) {
                  setState(() {
                    moderateTemp = value;
                  });
                }, minValue: coldTemp + 1, maxValue: warmTemp - 1, rangeText: '~ $warmTemp'),
                const SizedBox(height: 4),
                _buildTemperatureSetting('Cold', coldTemp, (value) {
                  setState(() {
                    coldTemp = value;
                  });
                }, minValue: 0, maxValue: moderateTemp - 1, rangeText: '~ $moderateTemp'),
                const SizedBox(height: 4),
                Container(
                  width: 340,
                  child: Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: const Text(
                        'Freezing',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'SF Pro',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Below ~',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'SF Pro',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          const SizedBox(width: 10),
                          DropdownButton<int>(
                            value: coldTemp,
                            onChanged: (int? newValue) {
                              if (newValue != null) {
                                setState(() {
                                  coldTemp = newValue;
                                });
                              }
                            },
                            items: _generateItems(0, moderateTemp - 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemperatureSetting(String label, int value, ValueChanged<int> onChanged, {required int minValue, required int maxValue, required String rangeText}) {
    return Container(
      width: 340,
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          title: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SF Pro',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: value,
                onChanged: (int? newValue) {
                  if (newValue != null) {
                    onChanged(newValue);
                  }
                },
                items: _generateItems(minValue, maxValue),
              ),
              const SizedBox(width: 10),
              Text(
                rangeText,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'SF Pro',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
