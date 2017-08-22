//
//  DefaultActivityViewController.swift
//
//  Copyright © 2017 Netguru Sp. z o.o. All rights reserved.
//  Licensed under the MIT License.
//

import UIKit

internal final class DefaultActivityViewController: UIActivityViewController {

    override init(activityItems: [Any], applicationActivities: [UIActivity]?) {
        super.init(activityItems: activityItems, applicationActivities: applicationActivities)
        self.excludedActivityTypes = [
            .airDrop,
            .postToFacebook,
            .postToVimeo,
            .postToWeibo,
            .postToFlickr,
            .postToTwitter,
            .addToReadingList,
            .assignToContact
        ]
    }
}
