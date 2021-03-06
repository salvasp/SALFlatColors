//
//  FlatColors.swift
//  SALFlatColors
//
//  Created by Salvatore Petrazzuolo on 18/11/2018.
//  Copyright © 2018 A&S. All rights reserved.
//

import UIKit

public enum FlatColors: Int, CaseIterable {
    case
    turquoise        = 0x1abc9c,
    emerald          = 0x2ecc71,
    peterRiver       = 0x3498db,
    amethyst         = 0x9b59b6,
    wetAsphalty      = 0x34495e,
    nephritis        = 0x27ae60,
    belizeHole       = 0x2980b9,
    wisteria         = 0x8e44ad,
    midnightBlue     = 0x2c3e50,
    sunFlower        = 0xf1c40f,
    carrot           = 0xe67e22,
    concrete         = 0x95a5a6,
    orange           = 0xf39c12,
    pumpkin          = 0xd35400,
    pomegranate      = 0xc0392b,
    silver           = 0xbdc3c7,
    asbestos         = 0x7f8c8d,
    chestnuteRose    = 0xd24d57,
    thunderbird      = 0xd91e18,
    oldBrick         = 0x96281b,
    flamingo         = 0xef4836,
    valencia         = 0xd64541,
    monza            = 0xcf000f,
    cinnabar         = 0xe74c3c,
    razzmatazz       = 0xdb0a5b,
    sunsetOrange     = 0xf64747,
    waxFlower        = 0xf1a9a0,
    cabaret          = 0xd2527f,
    newYorkPink      = 0xe08283,
    radicalRed       = 0xf62459,
    sunglo           = 0xe26a6a,
    snuff            = 0xdcc6e0,
    rebeccapurple    = 0x663399,
    honeyFlower      = 0x674172,
    wistful          = 0xaea8d3,
    plum             = 0x913d88,
    seance           = 0x9a12b3,
    mediumPurple     = 0xbf55ec,
    lightWisteria    = 0xbe90d4,
    sanMarino        = 0x446cb3,
    aliceBlue        = 0xe4f1fe,
    royalBlue        = 0x4183d7,
    pictonBlue       = 0x22a7f0,
    spray            = 0x81cfe0,
    shakespeare      = 0x52b3d9,
    hummingBird      = 0xc5eff7,
    dodgerBlue       = 0x19b5fe,
    ming             = 0x336e7b,
    ebonyClay        = 0x22313f,
    malibu           = 0x6bb9f0,
    summerySky       = 0x1e8bc3,
    chambray         = 0x3a539b,
    hoki             = 0x67809f,
    jellyBean        = 0x2574a9,
    jacksonsPurple   = 0x1f3a93,
    jordyBlue        = 0x89c4f4,
    steelBlue        = 0x4b77be,
    fountainBlue     = 0x5c97bf,
    mediumTurquoise  = 0x4ecdc4,
    aquaIsland       = 0xa2ded0,
    gossip           = 0x87d37c,
    darkSeaGreen     = 0x90c695,
    eucalyptus       = 0x26a65b,
    caribbeanGreen   = 0x03c9a9,
    silverTree       = 0x68c3a3,
    downy            = 0x65c6bb,
    mountainMeadow   = 0x1bbc9b,
    lightSeaGreen    = 0x1ba39c,
    mediumAquamarine = 0x66cc99,
    madang           = 0xc8f7c5,
    riptide          = 0x86e2d5,
    niagaraGreen     = 0x16a085,
    greenHaze        = 0x019875,
    oceanGreen       = 0x4daf7c,
    niagaraOne       = 0x2abb9b,
    jade             = 0x00b16a,
    salem            = 0x1e824c,
    observatory      = 0x049372,
    jungleGreen      = 0x26c281,
    capeHoney        = 0xfde3a7,
    california       = 0xf89406,
    fireBush         = 0xeb9532,
    tahitiGold       = 0xe87e04,
    casablanca       = 0xf4b350,
    crusta           = 0xf2784b,
    seaBuckthorn     = 0xeb974e,
    lightningYellow  = 0xf5ab35,
    ecstasy          = 0xf9690e,
    sandstorm        = 0xf9bf3b,
    jaffa            = 0xf27935,
    whiteSmoke       = 0xececec,
    lynch            = 0x6c7a89,
    pumice           = 0xd2d7d3,
    gallery          = 0xeeeeee,
    porcelain        = 0xecf0f1,
    iron             = 0xdadfe1,
    edward           = 0xabb7b7,
    cararra          = 0xf2f1ef,
    lapis            = 0x004b8d,
    teal             = 0x009688,
    cyan             = 0x00bcd4,
    indigo           = 0x3f51b5,
    niagara          = 0x5487a4,
    kale             = 0x5a7247,
    steel            = 0x607d8b,
    deepPurple       = 0x673ab7,
    brown            = 0x795548,
    lightGreen       = 0x8bc34a,
    purple           = 0x9c27b0,
    lime             = 0xcddc39,
    pink             = 0xe91e63,
    paleDogwood      = 0xefd1c6,
    red              = 0xf44336,
    deepOrange       = 0xff5722,
    amber            = 0xffc107,
    yellow           = 0xffeb3b,
    hazelnut         = 0xcfb095
    
    public var ordinal: Int {
        return FlatColors.allCases.index(of: self)!
    }
    
    public var uiColor: UIColor {
        return UIColor(
            red: CGFloat((self.rawValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((self.rawValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(self.rawValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1))
    }
    
    public var cgColor: CGColor {
        return self.uiColor.cgColor
    }
}

extension FlatColors {
    static func random() -> UIColor {
        return FlatColors.allCases.randomElement()!.uiColor
    }
}
