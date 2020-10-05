import 'package:flutter/material.dart';

class SliderModel {
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.imageAssetPath, this.title, this.desc});

  void setImageAssetPath(String getImageAssetPath) {
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDesc(String getDesc) {
    desc = getDesc;
  }

  String getImageAssetPath() {
    return imageAssetPath;
  }

  String getTitle() {
    return title;
  }

  String getDesc() {
    return desc;
  }
}

List<SliderModel> getSlides() {
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setDesc("Search Doctor we are offering the best speacialist.");
  sliderModel.setTitle("Search");
  sliderModel.setImageAssetPath("asset/doctor1.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Each patient carries his own doctor inside him..");
  sliderModel.setTitle("Patient");
  sliderModel.setImageAssetPath("asset/doctor2.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc(
      "Doctors are on the front lines of medicine, working tirelessly to help, heal, and offer hope to us all.");
  sliderModel.setTitle("Acknowledges");
  sliderModel.setImageAssetPath("asset/doctor3.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}
