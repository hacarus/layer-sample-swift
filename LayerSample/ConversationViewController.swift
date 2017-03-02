//
//  ConversationViewController.swift
//  LayerSample
//

import Atlas


class ConversationViewController : ATLConversationViewController, ATLConversationViewControllerDataSource, ATLConversationViewControllerDelegate {
    
    public func conversationViewController(_ conversationViewController: ATLConversationViewController, participantFor identity: LYRIdentity) -> ATLParticipant{
        return identity
    }
    
    public func conversationViewController(_ conversationViewController: ATLConversationViewController, attributedStringForDisplayOf date: Date) -> NSAttributedString{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en")
        formatter.dateFormat = "MMM dd, yyyy"
        return NSAttributedString(string: formatter.string(from: date))
    }
    
    public func conversationViewController(_ conversationViewController: ATLConversationViewController, attributedStringForDisplayOfRecipientStatus recipientStatus: [AnyHashable : Any]) -> NSAttributedString{
        print(recipientStatus)
        return NSAttributedString(string: "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
    }
}
