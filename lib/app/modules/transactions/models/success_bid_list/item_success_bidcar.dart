import 'package:json_annotation/json_annotation.dart';

part 'item_success_bidcar.g.dart';

@JsonSerializable()
class ItemSuccessBidCar {
  String? number;
  String? image;
  String? aabid;
  String? location;
  String? listnumber;
  String? trademark;
  String? species;
  String? biddate;
  String? biddeadline;
  String? bidamount;
  String? startingprice;
  String? inputamount;
  String? increasedamount;
  String? checkdetails;
  String? changecancel;
  String? landstatus;
  String? opportunityamount;
  String? aaoneplastic;
  String? listingstatus;

  ItemSuccessBidCar(
      {this.number,
      this.image,
      this.aabid,
      this.location,
      this.listnumber,
      this.trademark,
      this.species,
      this.biddate,
      this.biddeadline,
      this.bidamount,
      this.startingprice,
      this.inputamount,
      this.increasedamount,
      this.checkdetails,
      this.changecancel,
      this.landstatus,
      this.opportunityamount,
      this.aaoneplastic,
      this.listingstatus});

  factory ItemSuccessBidCar.fromJson(Map<String, dynamic> json) =>
      _$ItemSuccessBidCarFromJson(json);

  Map<String, dynamic> toJson() => _$ItemSuccessBidCarToJson(this);
}
