//
//  Colours.swift
//  TodoList
//
//  Created by Kirill Leonov on 31.03.2023.
//

import UIKit

enum FlatColor {
	enum Green {
		static let Fern = UIColor(hex: 0x6ABB72)
		static let MountainMeadow = UIColor(hex: 0x3ABB9D)
		static let ChateauGreen = UIColor(hex: 0x4DA664)
		static let PersianGreen = UIColor(hex: 0x2CA786)
	}

	enum Blue {
		static let PictonBlue = UIColor(hex: 0x5CADCF)
		static let Mariner = UIColor(hex: 0x3585C5)
		static let CuriousBlue = UIColor(hex: 0x4590B6)
		static let Denim = UIColor(hex: 0x2F6CAD)
		static let Chambray = UIColor(hex: 0x485675)
		static let BlueWhale = UIColor(hex: 0x29334D)
	}

	enum Violet {
		static let Wisteria = UIColor(hex: 0x9069B5)
		static let BlueGem = UIColor(hex: 0x533D7F)
	}

	enum Yellow {
		static let Energy = UIColor(hex: 0xF2D46F)
		static let Turbo = UIColor(hex: 0xF7C23E)
	}

	enum Orange {
		static let NeonCarrot = UIColor(hex: 0xF79E3D)
		static let Sun = UIColor(hex: 0xEE7841)
	}

	enum Red {
		static let TerraCotta = UIColor(hex: 0xE66B5B)
		static let Valencia = UIColor(hex: 0xCC4846)
		static let Cinnabar = UIColor(hex: 0xDC5047)
		static let WellRead = UIColor(hex: 0xB33234)
	}

	enum Gray {
		static let AlmondFrost = UIColor(hex: 0xA28F85)
		static let WhiteSnow = UIColor(hex: 0xFFFFFF)
		static let WhiteSmoke = UIColor(hex: 0xEFEFEF)
		static let Iron = UIColor(hex: 0xD1D5D8)
		static let IronGray = UIColor(hex: 0x75706B)
	}

	enum Black {
		static let BlackHole = UIColor(hex: 0x000000)
	}
}

enum Colors {
	static let red = UIColor.color(light: FlatColor.Red.WellRead, dark: FlatColor.Red.Cinnabar)
	static let orange = UIColor.color(light: FlatColor.Orange.NeonCarrot, dark: FlatColor.Orange.Sun)
	static let green = UIColor.color(light: FlatColor.Green.ChateauGreen, dark: FlatColor.Green.Fern)
	static let blue = UIColor.color(light: FlatColor.Blue.CuriousBlue, dark: FlatColor.Blue.PictonBlue)
	static let violet = UIColor.color(light: FlatColor.Violet.BlueGem, dark: FlatColor.Violet.Wisteria)
	static let black = UIColor.color(light: FlatColor.Black.BlackHole, dark: FlatColor.Gray.WhiteSmoke)
	static let dark = UIColor.color(light: FlatColor.Blue.BlueWhale, dark: FlatColor.Gray.Iron)
	static let white = UIColor.color(light: FlatColor.Gray.WhiteSnow, dark: FlatColor.Black.BlackHole)
	static let light = UIColor.color(light: FlatColor.Gray.WhiteSmoke, dark: FlatColor.Blue.BlueWhale)
}

enum Theme {
	static let mainColor = Colors.dark
	static let accentColor = Colors.red
	static let backgroundColor = Colors.light
	static let editorColor = Colors.light
}
