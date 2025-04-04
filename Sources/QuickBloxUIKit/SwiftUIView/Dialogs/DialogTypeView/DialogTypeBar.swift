//
//  DialogTypeBar.swift
//  QuickBloxUIKit
//
//  Created by Injoit on 28.03.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import SwiftUI
import QuickBloxDomain

public struct DialogTypeBar {
	var barSettings = QuickBloxUIKit.settings.dialogTypeScreen.dialogTypeBar
	
	@Binding public var selectedSegment: DialogType?
	
	public var onSelect: ((DialogType) -> Void)? = nil // ✅ new
}

extension DialogTypeBar: View {
	public var body: some View {
		HStack(spacing: barSettings.spacing) {
			ForEach(barSettings.displayedTypes, id:\.self) { type in
				Segment(selectedSegment: $selectedSegment, type: type) {
					onSelect?(type) // ✅ notify parent
				}
			}
		}
		.frame(height: barSettings.height)
		.background(barSettings.backgroundColor)
	}
}

public struct Segment: View {
	var barSettings = QuickBloxUIKit.settings.dialogTypeScreen.dialogTypeBar
	
	@Binding public var selectedSegment: DialogType?
	
	public var type: DialogType
	public var onTap: () -> Void // ✅ new
	
	public var body: some View {
		ZStack {
			Rectangle().fill(barSettings.backgroundColor)
		}
		.overlay(
			Button {
				selectedSegment = type
				onTap() // ✅ callback when tapped
			} label: {
				VStack(spacing: barSettings.segmentSpacing) {
					type.settings.image.foregroundColor(type.settings.color)
					Text(type.settings.title)
						.font(type.settings.font)
						.foregroundColor(type.settings.color)
				}
			}
				.background(barSettings.backgroundColor)
		)
	}
}

private extension DialogType {
    var settings: DialogTypeSegment {
        let settings = QuickBloxUIKit.settings.dialogTypeScreen.dialogTypeBar
        switch self {
        case .private, .unknown: return settings.privateSegment
        case .group: return settings.groupSegment
        case .public: return settings.publicSegment
        }
    }
}
