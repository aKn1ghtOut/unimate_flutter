import "package:flutter/material.dart";

class MenuItem {

  String _label;
  IconData _icon;
  VoidCallback onTap;
  Color selectedColor;
  bool selected;

  MenuItem(this._icon, this._label, this.onTap, this.selectedColor, {this.selected = false});

  String get label => _label;
  IconData get icon => _icon;
  
}