
public protocol JCOTPComponentDelegate: AnyObject {
    func didFinishEnter(code: String, completion: (Bool) -> Void )
    func onEnter(code: String)
    func onBeginEnter(code: String)
}
