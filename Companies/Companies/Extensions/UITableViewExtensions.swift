//
//  UITableViewExtensions.swift
//  Companies
//
//  Created by Andrea Agudo on 22/02/2019.
//  Copyright © 2019 aagudo. All rights reserved.
//

import UIKit

extension UITableView {

    func arrayInsertionDeletionAndNoopIndexes<T: Equatable>(objects: [T], originalObjects: [T]) -> ([Int], [Int], [Int]) {
        let insertions = objects.filter({ !originalObjects.contains($0) }).map({ objects.index(of: $0)! })
        let noops = originalObjects.filter({ objects.contains($0) }).map({ originalObjects.index(of: $0)! })
        let deletions = originalObjects.filter({ !objects.contains($0) }).map({ originalObjects.index(of: $0)! })

        return (insertions, deletions, noops)
    }

    func arrayInsertionDeletionAndNoopIndexPaths<T: Equatable>(objects: [T], originalObjects: [T], section: Int = 0) -> ([IndexPath], [IndexPath], [IndexPath]) {
        let (insertions, deletions, noops) = arrayInsertionDeletionAndNoopIndexes(objects: objects, originalObjects: originalObjects)

        let insertionIndexPaths = insertions.map({ IndexPath(row: $0, section: section) })
        let deletionIndexPaths = deletions.map({ IndexPath(row: $0, section: section) })
        let noopIndexPaths = noops.map({ IndexPath(row: $0, section: section) })

        return (insertionIndexPaths, deletionIndexPaths, noopIndexPaths)
    }

    func insertAndDeleteCellsForObjects<T: Equatable>(objects: [T], originalObjects: [T], section: Int = 0) {
        let (insertions, deletions, noops) = arrayInsertionDeletionAndNoopIndexPaths(objects: objects, originalObjects: originalObjects, section: section)

        if insertions.count > 0 || deletions.count > 0 ||  noops.count > 0 {
            beginUpdates()
            insertRows(at: insertions, with: .fade)
            deleteRows(at: deletions, with: .fade)
            reloadRows(at: noops, with: .fade)
            endUpdates()
        }
    }

}
