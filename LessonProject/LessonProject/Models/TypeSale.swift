//
//  TypeSale.swift
//  LessonProject
//
//  Created by Вадим on 06.09.2026.
//


//enum TypeSale {
//    case percent(Double)
//    case sum(Double)
//}

///Варианты промкодов
enum PromoCode: String {
    case swift10 = "SWIFT10"
    case student = "STUDENT"
    case sale500 = "SALE500"
    
    func applyPromo(promo: Double ) -> (Double, String) {
        switch self {
        case .swift10:
            return (promo * 0.9, "SWIFT10")
        case .student:
            return (promo * 0.95, "STUDENT")
        case .sale500:
            return (promo - 500, "SALE500")
        }
    }
}
