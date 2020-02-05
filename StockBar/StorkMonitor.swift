
import Foundation

class StorkMonitor {
    var firstLoop:Bool
    var indexBytesIn:Int
    var indexBytesOut:Int
    var headers:[Substring]
    var second = 60
    var timer = Timer()
    var stockID = "sh000001"
    
    init() {

        firstLoop = true
        indexBytesIn = 0
        indexBytesOut = 0
        headers = []
    }
    
    /// Start monitoring the amount of bytes in and out on the specified interface
    ///
    /// - Parameter interfaceName: name of the interface to monitor
    func startMonitoring(onUpdate: @escaping (String, String) -> Void) -> Void {
        //let urlString = "http://hq.sinajs.cn/list=sz000001"
        
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
            print("123")

            let url = URL(string: "https://hq.sinajs.cn/list="+self.stockID)
            let task = URLSession.shared.dataTask(with: url! as URL) { data, response, error in

              guard let data = data, error == nil else { return }

                let cfEncoding = CFStringEncodings.GB_18030_2000
                let encoding = CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfEncoding.rawValue))

                let str = NSString(data: data, encoding: encoding)
                let str2 = String(str!)
                let array : Array = str2.components(separatedBy: ",")
                print(str)
                
                let preValue = array[2]
                let curValue = array[3]
                var preValue_double:Double = Double(preValue) as! Double
                var curValue_double:Double = Double(curValue) as! Double
                var rate = String(format: "%.2f", (curValue_double-preValue_double)/preValue_double*100) + "%";
                onUpdate(curValue, rate);
            }

            task.resume()
            
        })
        


    }
    
    /// Stop monitoring
    func stopMonitoring() -> Void {
//       if timer != nil {
//        timer.invalidate() //销毁timer
//              timer = nil
//          }
    }
 
    
}
