//
//  RosterManager.swift
//  QuickBloxUIKit
//
//  Created by Tony Scamurra on 6/19/25.
//  Copyright © 2025 Tony Scamurra. All rights reserved.
//

import Foundation
import Quickblox
import Combine

public final class RosterManager: NSObject, ObservableObject {
	@Published public var pendingRequests: [UInt] = []

	override init() {
		super.init()
		setupListeners()
	}

	private func setupListeners() {
		QBChat.instance.addDelegate(self)
	}

    func sendChatRequest(to userID: UInt) {
        QBChat.instance.addUser(toContactListRequest: userID) { error in
            if let error = error {
                print("❌ Failed to send chat request: \(error.localizedDescription)")
            } else {
                print("✅ Chat request sent to user \(userID)")
            }
        }
    }

    func acceptRequest(from userID: UInt) {
        QBChat.instance.confirmAddContactRequest(userID)
        removePending(userID)
    }

    func rejectRequest(from userID: UInt) {
        QBChat.instance.rejectAddContactRequest(userID)
        removePending(userID)
    }

	func getApprovedContactIDs(completion: @escaping ([UInt]) -> Void) {
		if let contacts = QBChat.instance.contactList?.contacts {
			let approved = contacts.filter {
				$0.subscriptionState == QBPresenseSubscriptionState.presenceSubscriptionStateBoth
			}
			let userIDs = approved.compactMap { $0.userID }
			completion(userIDs)
		} else {
			completion([])
		}
	}


    private func removePending(_ userID: UInt) {
        if let index = pendingRequests.firstIndex(of: userID) {
            pendingRequests.remove(at: index)
        }
    }
}

extension RosterManager: QBChatDelegate {
	public func chatDidReceiveContactAddRequest(fromUser userID: UInt) {
        print("📥 Received chat request from \(userID)")
        if !pendingRequests.contains(userID) {
            pendingRequests.append(userID)
        }
    }

	public func chatDidReceiveAcceptContactRequest(fromUser userID: UInt) {
        print("✅ Your request was accepted by \(userID)")
    }

	public func chatDidReceiveRejectContactRequest(fromUser userID: UInt) {
        print("❌ Your request was rejected by \(userID)")
    }
}
