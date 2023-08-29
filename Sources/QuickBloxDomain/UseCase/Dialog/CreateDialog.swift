//
//  CreateDialog.swift
//  QuickBloxUIKit
//
//  Created by Injoit on 24.04.2023.
//  Copyright © 2023 QuickBlox. All rights reserved.
//

import QuickBloxLog

public class CreateDialog<DialogItem: DialogEntity, Repo: DialogsRepositoryProtocol>
where DialogItem == Repo.DialogEntityItem {
    private let repo: Repo
    private let dialog: DialogItem
    
    public init(dialog: DialogItem, repo: Repo) {
        self.dialog = dialog
        self.repo = repo
    }
    
    public func execute() async throws {
        do {
            let dialog = try await repo.create(dialogInRemote: dialog)
            try await repo.save(dialogToLocal: dialog)
        } catch  {
            prettyLog(error)
            throw error
        }
    }
}
