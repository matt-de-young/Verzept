//
//  TextFieldAlert.swift
//
//  Created by Chris Eidhof on 20.04.20.
//  Copyright © 2020 objc.io. All rights reserved.
//
import SwiftUI
import UIKit

extension UIAlertController {
    convenience init(alert: TextAlert) {
        self.init(title: alert.title, message: nil, preferredStyle: .alert)
        addTextField { $0.placeholder = alert.placeholder }
        addAction(UIAlertAction(title: alert.cancel, style: .cancel) { _ in
            alert.action(nil)
        })
        let textField = self.textFields?.first
        addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
            alert.action(textField?.text)
        })
    }
}



struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    let alert: TextAlert
    let content: Content
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
        UIHostingController(rootView: content)
    }
    
    final class Coordinator {
        var alertController: UIAlertController?
        init(_ controller: UIAlertController? = nil) {
            self.alertController = controller
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    
    func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
        uiViewController.rootView = content
        if isPresented && uiViewController.presentedViewController == nil {
            var alert = self.alert
            alert.action = {
                self.isPresented = false
                self.alert.action($0)
            }
            context.coordinator.alertController = UIAlertController(alert: alert)
            uiViewController.present(context.coordinator.alertController!, animated: true)
        }
        if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
            uiViewController.dismiss(animated: true)
        }
    }
}

public struct TextAlert {
    public var title: String
    public var placeholder: String = ""
    public var accept: String = "OK"
    public var cancel: String = "Cancel"
    public var action: (String?) -> ()
}

extension View {
    public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
        AlertWrapper(isPresented: isPresented, alert: alert, content: self)
    }
}

struct ContentView: View {
    @State var showsAlert = false
    var body: some View {
        VStack {
            Text("Hello, World!")
            Button("alert") {
                self.showsAlert = true
            }
        }
        .alert(isPresented: $showsAlert, TextAlert(title: "Title", action: {
            print("Callback \($0 ?? "<cancel>")")
        }))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView(showsAlert: true)
    }
}


////
////  TextFieldAlert.swift
////  Forking
////
////  Created by Matt de Young on 30.08.21.
////
//
//import SwiftUI
//
//struct TextFieldAlert<Presenting>: View where Presenting: View {
//    
//    @Binding var isShowing: Bool
//    @Binding var text: String
//    let presenting: Presenting
//    let title: String
//    
//    var body: some View {
//        GeometryReader { (deviceSize: GeometryProxy) in
//            ZStack {
//                self.presenting
//                    .disabled(isShowing)
//                VStack {
//                    Text(self.title)
//                    TextField(self.title, text: self.$text)
//                    Divider()
//                    HStack {
//                        Button(action: {
//                            withAnimation {
//                                self.isShowing.toggle()
//                            }
//                        }) {
//                            Text("Dismiss")
//                        }
//                    }
//                }
//                .padding()
//                .background(Color.white)
//                .frame(
//                    width: deviceSize.size.width*0.7,
//                    height: deviceSize.size.height*0.7
//                )
//                .shadow(radius: 1)
//                .opacity(self.isShowing ? 1 : 0)
//            }
//        }
//    }
//}
//
//extension View {
//    
//    func textFieldAlert(isShowing: Binding<Bool>,
//                        text: Binding<String>,
//                        title: String) -> some View {
//        TextFieldAlert(isShowing: isShowing,
//                       text: text,
//                       presenting: self,
//                       title: title)
//    }
//    
//}
//
////struct TextFieldAlert_Previews: PreviewProvider {
////    static var previews: some View {
//////        TextFieldAlert(isShowing: .constant(true), text: .constant(""), presenting: _, title: "Example Alert")
////        func textFieldAlert(isShowing: .constant(true),
////                            text: .constant(""),
////                            title: "Example Alert") -> some View {
////            TextFieldAlert(isShowing: isShowing,
////                           text: text,
////                           presenting: self,
////                           title: title)
////        }
////    }
////}
