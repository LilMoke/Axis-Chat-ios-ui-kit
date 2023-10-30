//
//  RemoteDialogEvent.swift
//  QuickBloxUIKit
//
//  Created by Injoit on 26.01.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

public enum RemoteDialogEvent<MessageItem: MessageEntity> {
    case create(_ dialogId: String, byUser: Bool, message: MessageItem)
    case update(_ message: MessageItem)
    case leave(_ dialogId: String)
    case userLeave(_ message: MessageItem)
    case removed(_ dialogId: String)
    case newMessage(_ message: MessageItem)
    case read( _ messageID: String, dialogID: String)
    case delivered( _ messageID: String, dialogID: String)
    case typing( _ userID: UInt, dialogID: String)
    case stopTyping( _ userID: UInt, dialogID: String)
}
