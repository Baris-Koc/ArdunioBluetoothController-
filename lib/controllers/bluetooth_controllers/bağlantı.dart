import 'dart:async';
import '../../models/cihaz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'cihaz_kullanilabilirligi.dart';

//Bağlı Cihaz Sayfasını Seçin
class BagliCihazSayfasiniSecin extends StatefulWidget {
  //Doğruysa, sayfa başlangıcında bağlı aygıtlar üzerinde keşif gerçekleştirilir.
  //Daha sonra, mevcut değillerse, seçimden devre dışı bırakılırlar.
  final bool kullanilabilirligiKontrolet; //checkAvailability
  final Function onCahtPage;

  const BagliCihazSayfasiniSecin(
      {this.kullanilabilirligiKontrolet = true, @required this.onCahtPage});

  @override
  _BagliCihazSayfasiSecin createState() => _BagliCihazSayfasiSecin();
}

//Cihaz Kullanılabilirliği hayır belki evet

//BluettohDevice sınıfından kalıtmış
class _KullanilaBilirligeSahipCihaz extends BluetoothDevice {
  //Kullanılabilirliğe Sahip Cihaz
  BluetoothDevice cihaz;
  CihazKullanilabilirligi kullanabilabilirlik;
  int rssi; //Alınan sinyal gücü göstergesi
//3 tane değişkeb alıyo 1.bt cihaz 2.Cihaz kullanabilirli 3alınan sinaly gücü
  _KullanilaBilirligeSahipCihaz(this.cihaz, this.kullanabilabilirlik,
      [this.rssi]);
}

//
class _BagliCihazSayfasiSecin extends State<BagliCihazSayfasiniSecin> {
  List<_KullanilaBilirligeSahipCihaz> cihazlar = [];

  // Availability kullanabilirlik
  StreamSubscription<BluetoothDiscoveryResult> _discoveryStreamSubscription;
  bool _kesfediyor;

//Boş Constructor
  _BagliCihazSayfasiSecin();

  @override
  //Widget ilk çalıştığında kesfediyor a kullanilabilirligiKontrolet değişkenini veriyo
  void initState() {
    super.initState();

    _kesfediyor = widget.kullanilabilirligiKontrolet;

//cihaz kesfediyor true ise
    if (_kesfediyor) {
      _kesfiBaslat();
    } else {
      _kesfetiYenidenBaslat();
    }

    //Bağlı cihazların bir listesini oluşturun
    FlutterBluetoothSerial.instance
        .getBondedDevices() //Bağlı cihazların listesini döndürür.
        .then((List<BluetoothDevice> bagliCihazlar) {
      //bitince bir liste dödürür cihaz bilgilerini temsil eden
      setState(() {
        //ekranı yeniler ve cihazlar listesini = bağlıCihazlar' a eşitler
        cihazlar = bagliCihazlar
            .map(
              (cihaz) => _KullanilaBilirligeSahipCihaz(
                cihaz,
                widget.kullanilabilirligiKontrolet
                    ? CihazKullanilabilirligi.belki
                    : CihazKullanilabilirligi.evet,
              ),
            )
            .toList();
      });
    });
  }

  void _kesfetiYenidenBaslat() {
    setState(() {
      _kesfediyor = true;
    });

    _kesfiBaslat();
  }

  void _kesfiBaslat() {
    _discoveryStreamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
      setState(() {
        Iterator i = cihazlar
            .iterator; //Bu Yinelenebilir öğenin öğelerini yinelemeye izin veren yeni bir Yineleyici döndürür
        while (i.moveNext()) {
          var _device = i.current;
          if (_device.cihaz == r.device) {
            _device.kullanabilabilirlik = CihazKullanilabilirligi.evet;
            _device.rssi = r.rssi;
          }
        }
      });
    });

    _discoveryStreamSubscription.onDone(() {
      setState(() {
        _kesfediyor = false;
      });
    });
  }

  @override
  void dispose() {
    // Memory lk'den (atıldıktan sonra `setState`) kaçının ve keşif işlemini iptal edin
    _discoveryStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var list = cihazlar
        .map(
          (_cihaz) => BluetoothCihazListesiGirisi(
            cihaz: _cihaz.cihaz,
            // rssi: _device.rssi,
            // enabled: _device.availability == _DeviceAvailability.yes,
            onTap: () {
              widget.onCahtPage(_cihaz.cihaz);
            },
          ),
        )
        .toList();
    return ListView(
      children: list,
    );
  }
}
