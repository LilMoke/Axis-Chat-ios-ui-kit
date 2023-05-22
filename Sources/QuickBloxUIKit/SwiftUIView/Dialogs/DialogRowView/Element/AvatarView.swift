//
//  DialogRowAvatar.swift
//  QuickBloxUIKit
//
//  Created by Injoit on 21.03.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import SwiftUI

public struct AvatarView {
    
    let settings = QuickBloxUIKit.settings.dialogsScreen.dialogRow.avatar
    
    public var image: Image
    public var height: CGFloat
    public var isShow: Bool
}

extension AvatarView: View {
    public var body: some View {
        if isShow == false {
            EmptyView()
        } else {
            Avatar(image: image, height: height)
        }
    }
}

public struct Avatar: View {
    public var image: Image
    public var height: CGFloat
    
    public var body: some View {
        image.avatarModifier(height: height)
    }
}

extension DialogRowView {
    func avatar(image: Image,
                height: CGFloat,
                isShow: Bool = true) -> Self {
        var row = Self.init(self)
        row.avatarView = AvatarView(image: image,
                                    height: height,
                                    isShow: isShow)
        return row
    }
}

extension Image {
    func avatarModifier(height: CGFloat) -> some View {
        self
            .resizable()
            .scaledToFill()
            .frame(width: height, height: height)
            .clipShape(Circle())
    }
}

struct DialogRowAvatar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AvatarView(image: Image("AvatarUser", bundle: .module), height: 56.0, isShow: true)
                .previewDisplayName("Empty")
                .preferredColorScheme(.dark)
            AvatarView(image: Image("AvatarUser", bundle: .module), height: 56.0, isShow: true)
                .previewDisplayName("With Url Photo")
            AvatarView(image: Image("AvatarGroup", bundle: .module), height: 56.0, isShow: true)
                .previewSettings(name: "Group")
            AvatarView(image: Image("AvatarPublic", bundle: .module), height: 56.0, isShow: true)
                .previewSettings(name: "Public")
            AvatarView(image: Image("TestAvatar", bundle: .module), height: 40.0, isShow: true)
                .previewSettings(name: "Custom Avatar")
            AvatarView(image: Image("TestAvatar", bundle: .module), height: 40.0, isShow: true)
                .previewSettings(name: "Custom Image Auto Crop")
        }.previewLayout(.fixed(width: 56, height: 56))
    }
}
