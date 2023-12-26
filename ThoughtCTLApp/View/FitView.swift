//
//  FitView.swift
//  ThoughtCTLApp
//
//  Created by Dipendra Dubey on 26/12/23.
//

import SwiftUI

struct FitView: View {
    let fullText = "Thank You for subscribing. Our team will get back to you."
    var body: some View {
            GeometryReader { geometry in
                VStack {
                    //Since there is horizontal padding 8px
                    if willTextFit(width: (geometry.size.width-16)) {
                        Text(fullText)
                            .font(.system(size: 15))
                            .padding(.horizontal, 8)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.blue)
                    } else {
                        Text("Thanks for subscribing")
                            .font(.system(size: 15))
                            .padding(.horizontal, 8)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color.red)
                    }
                }
            }
        }

        func willTextFit(width: CGFloat) -> Bool {
            let text = fullText
            let textWidth = text.width(for: .title)
            return textWidth <= width
        }
}

extension String {
    func width(for font: Font) -> CGFloat {
        let text = NSAttributedString(string: self, attributes: [.font: UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 15))])
        let size = text.size()
        return size.width
    }
}

#Preview {
    FitView()
}
