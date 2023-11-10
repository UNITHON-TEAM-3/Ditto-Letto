import SwiftUI
import DesignSystem

struct OnboardingImageViewer: View {
    private let onboardingViews: [(image: Image, color: Color)] = [
        (Image(uiImage: .Image.first), .clear),
        (Image(uiImage: .Image.second), .clear),
        (Image(uiImage: .Image.third), .clear),
        (Image(uiImage: .Image.fourth), .clear)
    ]

    init() {
        UIPageControl.appearance().setIndicatorImage(.Image.pinkHeart, forPage: UIPageControl.appearance().currentPage)
    }

    var body: some View {
        TabView {
            ForEach(self.onboardingViews.indices, id: \.self) { index in
                VStack {
                    ZStack(alignment: .center) {
                        onboardingViews[index].image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: UIScreen.main.bounds.height * 0.811)
                            .padding(.top, UIScreen.main.bounds.height * 0.137)
                    }
                }
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .edgesIgnoringSafeArea(.top)
    }

}
