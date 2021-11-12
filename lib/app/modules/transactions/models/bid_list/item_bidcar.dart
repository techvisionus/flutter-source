import 'package:json_annotation/json_annotation.dart';

part 'item_bidcar.g.dart';

@JsonSerializable()
class ItemBidCar {
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

  ItemBidCar(
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

  factory ItemBidCar.fromJson(Map<String, dynamic> json) =>
      _$ItemBidCarFromJson(json);

  Map<String, dynamic> toJson() => _$ItemBidCarToJson(this);
}
