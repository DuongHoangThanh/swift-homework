//: [Previous](@previous)

import Foundation


// Ex3:
protocol SituationHandlerDelegate {
    func situationDidOccur(type: String)
    func situationDidEnd(type: String)
}

class SituationHandler {
    var delegate: SituationHandlerDelegate?
    
    func triggerSituation(type: String) {
        print("Tình huống xảy ra: \(type)")
        delegate?.situationDidOccur(type: type)
    }
    
    func endSituation(type: String) {
        print("Tình huống kết thúc: \(type)")
        delegate?.situationDidEnd(type: type)
    }
}

class GameObserver: SituationHandlerDelegate {
    func situationDidOccur(type: String) {
        print("Notify: Da phat hien tinh huong xay ra - \(type)")
    }
    
    func situationDidEnd(type: String) {
        print("Notify: Tinh huong \(type) da ket thuc ")
    }
}

let std = SituationHandler()
let gsv = GameObserver()
std.delegate = gsv
std.triggerSituation(type: "Fight")
std.endSituation(type: "Die")


// Ex2:
protocol MessageSenderDelegate {
    func messageDidSend()
    func messageDidFailWithError(error: Error)
}

class MessageSender {
    var delegate: MessageSenderDelegate?
    
    func send(message: String) {
        
        let isSuccess = Bool.random()
        
        if isSuccess {
            print("Message has been sent: \(message).")
            delegate?.messageDidSend()
        } else {
            let error = NSError(domain: "com.example.MessageSender", code: 1, userInfo: [NSLocalizedDescriptionKey: "Không thể gửi tin nhắn"])
            print("Error sending message.")
            delegate?.messageDidFailWithError(error: error)
        }
    }
}

class MessageObserver: MessageSenderDelegate {
    func messageDidSend() {
        print("Notify: DONE!")
    }
    
    func messageDidFailWithError(error: any Error) {
        print("Notify: ERROR - \(error.localizedDescription)")
    }
}

let messageSender = MessageSender()
let messageObserver = MessageObserver()
func messageSender;.delegate = messageObserver
messageSender.send(message: "Hello, my name is Thanh")



// Ex1:
protocol DownloadManagerDelegate {
    func downloadDidStart()
    func downloadDidProgress(percent: Double)
    func downloadDidFinish(data: Data)
}

class DownloadManager {
    var delegate: DownloadManagerDelegate?
    
    func startDownload() {
        delegate?.downloadDidStart()
        
        for i in stride(from: 0, to: 100, by: 10) {
            delegate?.downloadDidProgress(percent: Double(i))
            sleep(1)
        }
        
        let fakeData = Data("Data ... ".utf8)
        delegate?.downloadDidFinish(data: fakeData)
    }
}

class DownloadObserver: DownloadManagerDelegate {
    func downloadDidStart() {
        print("Start!")
    }
    
    func downloadDidProgress(percent: Double) {
        print("\(percent)% ")
    }
    
    func downloadDidFinish(data: Data) {
        print("Finish => \(data)")
    }
}

let downloadObServer = DownloadObserver()

let downloadManager = DownloadManager()
    func downloadManager;.delegate = downloadObServer
downloadManager.startDownload()







