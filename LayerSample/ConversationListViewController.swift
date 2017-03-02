//
//  ConversationListViewController.swift
//  LayerSample
//

import Atlas

class ConversationListViewController : ATLConversationListViewController, ATLConversationListViewControllerDelegate, ATLConversationListViewControllerDataSource {
        
    public func conversationListViewController(_ conversationListViewController: ATLConversationListViewController, didSelect conversation: LYRConversation){
        let nextViewController = ConversationViewController(layerClient: self.layerClient)
        nextViewController.conversation = conversation
        self.navigationController?.show(nextViewController, sender: nil)
    }
    
    public func conversationListViewController(_ conversationListViewController: ATLConversationListViewController, titleFor conversation: LYRConversation) -> String {
        return "Chat"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
    }
        
}
